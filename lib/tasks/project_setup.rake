
namespace :dvdclub do
  namespace :app do
    task :setup => :environment do
      admin = User.create!(:login => 'admin@dvdclub.com', 
                          :email => 'admin@dvdclub.com', 
                          :email_confirmation => 'admin@dvdclub.com', 
                          :password => 'password', 
                          :password_confirmation => 'password')
      role = Role.create(:name => 'admin')
      admin.roles << role
      
      role = Role.create(:name => 'user')
    
      ['Blue-Ray', 'DVD'].each do |dvd_format_name|
        DvdFormat.create(:name => dvd_format_name) 
      end
      
      ['Action', 'Comédie', 'Dessin Animé', 'Emotion', 'Famille & Enfant', 'Fantastique', 'Frisson', 'Grand Classique',
      'Guerre', 'Historique & Epoque', 'Hors Film & Documentaire', 'Manga', 'Romance', 'Science-fiction', 'Série TV', 'Sport',
      'Théâtre & Spectacle', 'Thriller', 'Western'].each do |club_type_name|
        ClubTopic.create(:name => club_type_name)  
      end
      
    end    
  end
end
