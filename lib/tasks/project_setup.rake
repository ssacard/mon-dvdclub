namespace :dvdclub do
  namespace :app do
    desc 'init dvdclub'
    task :setup => :environment do
      admin = User.create!(:login => 'admin@dvdclub.com',
                          :email => 'admin@dvdclub.com',
                          :password => 'password')
      role = Role.create(:name => 'admin')
      admin.roles << role

      role = Role.create(:name => 'user')

      ['Blue-Ray', 'DVD'].each do |dvd_format_name|
        DvdFormat.create(:name => dvd_format_name)
      end
      [ "Action, Aventure, Policier et Thriller",
        "Cinéma asiatique",
        "Comédie",
        "Documentaires et Divers",
        "Drame et Émotion",
        "Enfants, Jeunesse et Famille",
        "Fantastique, Horreur et Science-fiction",
        "Grands classiques",
        "Manga",
        "Musique et Films musicaux",
        "Romance",
        "Spectacles et Humour",
        "Séries TV",
        "Érotisme",
        "Autres"
        ].each do |club_type_name|
        DvdCategory.create(:name => club_type_name)
      end

      ["Club de voisins", "Club du bureau", "Club distant", "Autre"].each do |type_de_club|
        ClubTopic.create(:name => type_de_club)
      end

    end

    desc 'Full reset'
    task :reset => :environment do
      Rake::Task["db:drop"].invoke
      Rake::Task["db:create"].invoke
      Rake::Task["db:migrate"].invoke
      Rake::Task["dvdclub:app:setup"].invoke
      #Rake::Task["db:fixtures:load"].invoke
    end
  end

  namespace :db do
    desc 'database related tasks'
    task :fixtures => :environment do
      sql  = "SELECT * FROM %s"
      skip_tables = ["schema_info"]
      ActiveRecord::Base.establish_connection
      (ActiveRecord::Base.connection.tables - skip_tables).each do |table_name|
        i = "000"
        File.open("#{RAILS_ROOT}/test/fixtures/#{table_name}.yml", 'w') do |file|
          data = ActiveRecord::Base.connection.select_all(sql % table_name)
          file.write data.inject({}) { |hash, record|
            hash["#{table_name}_#{i.succ!}"] = record
            hash
          }.to_yaml
        end
      end
    end
  end
end