set :application, 'eniv'
set :repo_url, 'git@github.com:davoclavo/eniv.git'
set :branch, 'master'
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

set :deploy_to, '/var/web/eniv'
set :scm, :git

# set :format, :pretty
# set :log_level, :debug
# set :pty, true
# set :shell, '/bin/bash'
set :default_shell, :bash
set :linked_files, %w{config/database.yml config/secrets.yml .env .fog}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}
set :rvm_type, :user
# set :default_env, { path: "/opt/ruby/bin:$PATH" }
# set :keep_releases, 5

namespace :deploy do

  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      # Your restart mechanism here, for example:
    end
  end

  after :restart, :clear_cache do
    on roles(:web), in: :groups, limit: 3, wait: 10 do
      # Here we can do anything such as:
      # within release_path do
      #   execute :rake, 'cache:clear'
      # end
    end
  end

  # before :setup,     'rvm:install_rvm'
  after  :started,   'delayed_job:start'
  after  :restart,   'puma:restart'
  after  :restart,   'delayed_job:restart'
  after  :finishing, 'deploy:cleanup'
end


desc "Check that we can access everything"
task :check_write_permissions do
  on roles(:all) do |host|
    if test("[ -w #{fetch(:deploy_to)} ]")
      info "#{fetch(:deploy_to)} is writable on #{host}"
    else
      error "#{fetch(:deploy_to)} is not writable on #{host}"
    end
  end
end

task :install_nginx do
  on roles(:web) do
    run "#{sudo} add-apt-repository ppa:nginx/stable",:pty => true do |ch, stream, data|
      if data =~ /Press.\[ENTER\].to.continue/
        #prompt, and then send the response to the remote process
        ch.send_data(Capistrano::CLI.password_prompt("Press enter to continue:") + "\n")
      else
        #use the default handler for all other text
        Capistrano::Configuration.default_io_proc.call(ch,stream,data)
      end
    end
  end

  run "#{sudo} apt-get -y update"
  run "#{sudo} apt-get -y install nginx"
end
