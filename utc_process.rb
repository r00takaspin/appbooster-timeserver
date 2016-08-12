require 'socket'
require 'etc'
Dir[File.dirname(__FILE__) + '/src/*.rb'].each { |file| require file }

acceptor = TCPServer.new('localhost', 8082)

puts '[MULTI] Listening on port 8082'

trap('EXIT') { acceptor.close }

# create number of child processes equal to core number
Etc.nprocessors.times do
  fork do
    trap('INT') { exit }

    puts "child #{$PID} accepting on shared socket (localhost:8082)"
    loop do
      socket = acceptor.accept
      Application.new(socket).run
    end
    exit
  end
end

trap('INT') do
  exit
end

Process.waitall
