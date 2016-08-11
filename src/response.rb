class Response
  attr_reader :socket
  attr_reader :result

  def initialize(result, socket)
    @result = result
    @socket = socket
  end

  def send_back
    headers = ['HTTP/1.1 200 OK',
               'server: ruby',
               'content-type: text/plain; charset=utf-8',
               "content-length: #{@result.length}\r\n\r\n"].join("\r\n")
    @socket.puts headers
    @socket.puts @result
    @socket.close
  end

  def self.bad_request(socket)
    @result = 'Something went wrong'
    headers = ['HTTP/1.1 400 Bad Request',
               'server: ruby',
               'content-type: text/html; charset=utf-8',
               "content-length: #{@result.length}\r\n\r\n"].join("\r\n")
    socket.puts headers
    socket.puts @result
    socket.close
  end
end