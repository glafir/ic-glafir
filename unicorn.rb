worker_processes 3
working_directory "/home/glafir/RoR/ic-glafir/"

preload_app true

timeout 36000

listen "/home/glafir/RoR/ic-glafir/tmp/sockets/unicorn.sock", :backlog => 128

pid "/home/glafir/RoR/ic-glafir/tmp/pids/unicorn.pid"

stderr_path "/home/glafir/RoR/ic-glafir/log/unicorn.stderr.log"
stdout_path "/home/glafir/RoR/ic-glafir/log/unicorn.stdout.log"

before_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
end
