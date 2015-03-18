worker_processes 1
working_directory "/home/glafir/RoR/ic.glafir.ru/"

preload_app true

timeout 180

listen "/home/glafir/RoR/ic.glafir.ru/tmp/sockets/unicorn.sock", :backlog => 64

pid "/home/glafir/RoR/ic.glafir.ru/tmp/pids/unicorn.pid"

stderr_path "/home/glafir/RoR/ic.glafir.ru/log/unicorn.stderr.log"
stdout_path "/home/glafir/RoR/ic.glafir.ru/log/unicorn.stdout.log"

before_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.connection.disconnect!
end

after_fork do |server, worker|
    defined?(ActiveRecord::Base) and
        ActiveRecord::Base.establish_connection
end
