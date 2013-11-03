application_path = Dir.pwd
railsenv = ENV['RAILS_ENV']

directory application_path
# daemonize true

threads 1, 6
workers 2
stdout_redirect
"#{application_path}/log/puma-#{railsenv}.stdout.log"
"#{application_path}/log/puma-#{railsenv}.stderr.log"
pidfile "#{application_path}/tmp/pids/puma-#{railsenv}.pid"
state_path "#{application_path}/tmp/pids/puma-#{railsenv}.state"
bind "unix://#{application_path}/tmp/sockets/#{railsenv}.socket"

# on_worker_boot do
#   require "active_record"
#   cwd = File.dirname(__FILE__)+"/.."
#   ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
#   ActiveRecord::Base.establish_connection(ENV["DATABASE_URL"] || YAML.load_file("#{cwd}/config/database.yml")[ENV["RAILS_ENV"]])
# end
