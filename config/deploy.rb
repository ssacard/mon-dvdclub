set :application, "mondvdclub"

set :scm,                   :git
set :deploy_via,            :remote_cache
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :scm_verbose, true

set :deploy_to, "/home/deploy/#{application}" 
set :use_sudo,  false
set :user, 'deploy'

set :rake,     '/opt/ruby/bin/rake'

role :web,       'www.mondvdclub.fr'
role :app,       'www.mondvdclub.fr'
role :db,        'www.mondvdclub.fr', :primary => true
 
set :repository, "git@github.com:Malacara/mon-dvdclub.git"
set :branch,     'old_design'

desc "After update code"
task :after_update_code do
  %w(database.yml).each do |file|
    run "cp #{shared_path}/resources/#{file} #{release_path}/config/"
  end
end  

namespace :deploy do
  # Restart passenger on deploy
  desc "Restarting mod_rails with restart.txt"
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end
end
