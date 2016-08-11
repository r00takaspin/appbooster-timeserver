require 'time'
require 'tzinfo'

class DateCalculator
  attr_reader :date
  attr_reader :cities

  def initialize(date = Time.now, cities = nil)
    @date = date
    @cities = cities
    @repository = CityRepository.new
  end

  def self.format_date(date)
    date.strftime("%Y-%m-%d %H:%I:%S")
  end

  def print
    results = ["UTC: #{self.class.format_date(@date.utc)}"]
    if @cities
      @cities.each do |city|
        utc = @repository.utc_by_name(city)
        if utc
          tz = TZInfo::Timezone.get(utc)
          results << "#{city}: #{tz.utc_to_local(@date)}"
        end
      end
    end
    results.join("\n")
  end
end