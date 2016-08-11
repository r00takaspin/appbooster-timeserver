require 'uri'
require 'singleton'
require 'cgi'

class Application
  include Singleton

  def init(socket)
    request = Request.new(socket)

    if request.path =~ /^\/time/
      if request.params
        cities = request.params.split(',').map { |x| CGI.unescape(x) }
        calculator = DateCalculator.new(Time.now, cities)
        Response.new(calculator.print, socket).send_back
      end
    else
      Response.bad_request(socket)
    end
  end
end