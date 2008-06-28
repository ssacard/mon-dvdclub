namespace :dvdclub do
  namespace :app do
    task :create_admin_and_roles => :environment do
      admin = User.create!(:login => 'admin@dvdclub.com', 
                          :email => 'admin@dvdclub.com', 
                          :email_confirmation => 'admin@dvdclub.com', 
                          :password => 'password', 
                          :password_confirmation => 'password')
      role = Role.create(:name => 'admin')
      admin.roles << role
      role = Role.create(:name => 'user')
    end
  end
end
