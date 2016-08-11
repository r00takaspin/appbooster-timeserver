require 'http/parser'

class Request
  attr_reader :request_body
  attr_reader :socket
  attr_reader :parser

  def initialize(socket)
    @socket = socket
    @parser = Http::Parser.new
    @parser << body
  end

  def path
    @parser.request_url
  end

  def params
    path.split('?').count > 1 ? URI.unescape(path.split('?').pop) : nil
  end

  private
  def body
    @request_body ||= read_body
  end

  def read_body
    result = ''
    while ((line = @socket.gets) && (line != "\r\n"))
      result += line
    end
    result
  end
end
