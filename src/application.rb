require 'uri'
require 'singleton'
require 'cgi'
require 'pry'

#
# Routing and I/O operations
#
class Application
  attr_reader :socket
  attr_reader :request

  def initialize(socket)
    @socket = socket
    @request = Request.new(socket)
  end

  def run
    if route_matches?
      send_time(socket)
    else
      Response.bad_request(socket)
    end
  rescue
    Response.error(socket)
  ensure
    socket.close
  end

  private

  def route_matches?
    @request.path =~ %r{^\/time}
  end

  def send_time(socket)
    calculator = DateCalculator.new(Time.now.utc, cities)
    Response.new(calculator.print, socket).send_back
  end

  def cities
    params = @request.params
    params ? params.split(',').map { |city_name| CGI.unescape(city_name) } : nil
  end
end
