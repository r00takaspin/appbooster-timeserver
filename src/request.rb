require 'http/parser'

#
# Wrapper around Http::Parser
#
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
    url_parts.count > 1 ? URI.unescape(url_parts.pop) : nil
  end

  private

  def body
    @request_body ||= read_body
  end

  def url_parts
    path.split('?')
  end

  def read_body
    result = ''
    while (line = @socket.gets) && (line != "\r\n")
      result += line
    end
    result
  end
end
