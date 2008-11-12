set :application, "dvdclub"

set :scm,                   :git
set :deploy_via,            :remote_cache
set :git_enable_submodules, 1
set :deploy_via, :remote_cache
set :git_shallow_clone, 1
set :scm_verbose, true

set :deploy_to, "/var/www/railsapp/#{application}" 
set :use_sudo,  false

set :mongrel_rails, '/usr/bin/mongrel_rails'
set :rake_path,     '/usr/bin/rake'

role :web,       'www.xilinus.com'
role :app,       'www.xilinus.com'
role :db,        'www.xilinus.com', :primary => true
 
set :repository, "git@git.xilinus.com:/var/git/#{application}"
set :branch,     'master'

desc "After update code"
task :after_update_code do
  %w(database.yml mongrel_cluster.yml).each do |file|
    run "cp #{shared_path}/resources/#{file} #{release_path}/config/"
  end
end  

namespace :deploy do
  task :start, :roles => :app do
    run "cd #{current_path} && mongrel_rails cluster::start"
  end
  task :stop, :roles => :app do
    run "cd #{current_path} && mongrel_rails cluster::stop"
  end
  task :restart, :roles => :app do
    run "cd #{current_path} && mongrel_rails cluster::restart"
  end
end


task :run_test, :roles => :app do
  run "cd #{current_path} && rake test"
end
