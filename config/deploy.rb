# Add RVM's lib directory to the load path.
$:.unshift(File.expand_path('./lib', ENV['rvm_path']))

# Load RVM's capistrano plugin.    
require "rvm/capistrano"

set :rvm_ruby_string, '1.9.2'
set :rvm_type, :user  # Don't use system-wide RVM

require "bundler/capistrano"
set :user, 'thor'
set :domain, 'repair.mooo.com'
set :application, 'repair.mooo.com'
set :applicationdir, "/home/thor/repair_shop"

set :scm, :git
set :repository,  "git@github.com:kairo77/repair-shop.git"
set :branch, 'master'
set :scm_verbose, true
ssh_options[:forward_agent] = true
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa_thor")]

role :web, domain
role :app, domain
role :db,  domain, :primary => true

set :deploy_to, applicationdir
set :deploy_via, :export
after "deploy", "deploy:cleanup" # keep only the last 5 releases

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  desc "Tell Passenger to restart the app."
  task :restart do
    run "touch #{current_path}/tmp/restart.txt"
  end
  
  desc "Symlink shared configs and folders on each release."
  task :symlink_shared do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
  end
  
  desc "Sync the public/assets directory and database.yml"
  task :assets do
    system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
    put File.read("config/database.yml"), "#{shared_path}/config/database.yml"
  end
end

after 'deploy:update_code', 'deploy:assets'
after 'deploy:assets', 'deploy:symlink_shared'