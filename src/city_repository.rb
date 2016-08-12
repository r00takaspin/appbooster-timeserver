require 'json'
#
# Search timezone by substring
#
class CityRepository
  attr_reader :timezone_list

  def initialize
    file = File.read('./timezones.json')
    @timezone_list = JSON.parse(file)
  end

  def utc_by_name(str)
    result = @timezone_list.select do |tz|
      tz['text'].downcase.index(str.downcase)
    end
    result.count > 0 ? result.first['utc'].first : nil
  end
end
