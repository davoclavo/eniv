#!/usr/bin/env puma
rails_root=ENV['RAILS_ROOT']


directory rails_root
environment ENV['RAILS_ENV']
# daemonize true
pidfile "#{rails_root}/tmp/pids/puma.pid"
state_path "#{rails_root}/tmp/pids/puma.state"
# stdout_redirect '#{rails_root}/log/puma_error.log', '#{rails_root}/log/puma_access.log', true
threads 0,16
bind "unix://#{rails_root}/tmp/sockets/puma.sock"
port 3000

workers 0
preload_app!
