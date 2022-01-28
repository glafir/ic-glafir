require 'puma'
require 'fileutils'
workers 4
threads 4,16
app_dir = File.expand_path("/home/glafir/RoR/ic-glafir", __FILE__)
log_dir = "#{app_dir}/log"
shared_dir = "/var/cache/RoR/ic-glafir/"
FileUtils.mkdir_p "#{shared_dir}"
FileUtils.mkdir_p "#{shared_dir}/sockets"
FileUtils.mkdir_p "#{shared_dir}/pids"
FileUtils.mkdir_p "#{shared_dir}/cache"
FileUtils.mkdir_p "#{shared_dir}/sessions"
# Default to production
rails_env = ENV['RAILS_ENV'] || "production"
environment rails_env

# Set up socket location
bind "unix://#{shared_dir}/sockets/puma.sock"

# Logging
stdout_redirect "#{app_dir}/log/puma.stdout.log", "#{app_dir}/log/puma.stderr.log", true

# Set master PID and state locations
pidfile "#{shared_dir}/pids/puma.pid"
state_path "#{shared_dir}/pids/puma.state"
activate_control_app

on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")[rails_env])
end

preload_app!
plugin :tmp_restart

