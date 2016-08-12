require 'socket'
require 'uri'
Dir[File.dirname(__FILE__) + '/src/*.rb'].each { |file| require file }

server = TCPServer.open 8081

puts '[SINGLE] Listening on port 8081'

loop do
  socket = server.accept
  Application.new(socket).run
end
