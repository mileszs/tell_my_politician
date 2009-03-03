# set :stages, %w(staging production)
# set :default_stage, "staging"
# require 'capistrano/ext/multistage'

set :application, "tellmypolitician.com"

# Use git
set :scm, :git
set :repository, "git@github.com:mileszs/tell_my_politician.git"
set :deploy_via, :remote_cache

set :deploy_to, "/home/tellmyp/public_html/tellmypolitician.com"
set :user, 'tellmyp'
set :use_sudo, false

role :web, "tellmypolitician.com"
role :app, "tellmypolitician.com"
role :db,  "tellmypolitician.com", :primary => true

before "deploy:migrate", "db:symlink"

namespace :deploy do

  desc "Default deploy - updated to run migrations"
  task :default do
    set :migrate_target, :latest
    update_code
    migrate
    symlink
    restart
  end

  desc "Restart Passenger"
  task :restart do
    send(run_method, "touch #{current_path}/tmp/restart.txt")
  end

  [:start, :stop].each do |t|
    desc "#{t} task is a no-op with mod_rails"
    task t, :roles => :app do ; end
  end

  desc "Run this after every successful deployment"
  task :after_default do
    cleanup
  end

end

namespace :db do
  desc "Make symlink for database yaml"
  task :symlink do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
  end
#   desc "Create database password in shared path"
#   task :password do
#     set :db_password, Proc.new { Capistrano::CLI.password_prompt("Remote database password: ") }
#     run "mkdir -p #{shared_path}/config"
#     put db_password, "#{shared_path}/config/dbpassword"
#   end
end
