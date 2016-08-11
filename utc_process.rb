require 'socket'
require 'etc'
Dir[File.dirname(__FILE__) + '/src/*.rb'].each {|file| require file }

acceptor = TCPServer.new('localhost', 8082)

puts "[MULTI] Listening on port 8082"

#убиваем сокет при завершении процесса
trap('EXIT') { acceptor.close }

# создаем число процессов равное числу ядер
Etc.nprocessors.times do
  fork do
    trap('INT') { exit }

    puts "child #$$ accepting on shared socket (localhost:4242)"
    loop {
      # puts 'STARTING PROCESS'
      socket, addr = acceptor.accept
      a = Application.instance
      a.init(socket)
    }
    exit
  end
end

trap('INT') { puts "\nbailing" ; exit }

Process.waitall