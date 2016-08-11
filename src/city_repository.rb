require 'singleton'
require 'json'

class CityRepository
  attr_accessor :timezone_list

  def initialize
    file = File.read('./timezones.json')
    @timezone_list = JSON.parse(file)
  end

  def utc_by_name(str)
    @timezone_list.each do |tz|
      if tz['text'].downcase.index(str.downcase)
        return tz['utc'].first
      end
    end
    nil
  end
end