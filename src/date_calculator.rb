require 'tzinfo'

#
# Formatted date output depending on city name
#
class DateCalculator
  attr_reader :date
  attr_reader :cities
  attr_reader :city_times

  #
  # Useful structure for storing city name and time
  #
  class CityTime
    attr_reader :name
    attr_reader :time

    def initialize(name, time)
      @name = name
      @time = time
    end

    def print
      "#{@name}: #{self.class.format_date(time)}"
    end

    def self.format_date(date)
      date.strftime('%Y-%m-%d %H:%M:%S')
    end
  end

  def initialize(date = Time.now.utc, cities = [])
    @date = date
    @cities = cities
    @repository = CityRepository.new
    @city_times = [CityTime.new('UTC', @date)]
    fill_cities
  end

  def print
    @city_times.map(&:print).join("\n")
  end

  private

  def fill_cities
    @cities.each do |city|
      utc = @repository.utc_by_name(city)
      if utc
        tz = TZInfo::Timezone.get(utc)
        @city_times << CityTime.new(city, tz.utc_to_local(@date))
      end
    end
  end
end
