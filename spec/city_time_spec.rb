require 'spec_helper'

describe DateCalculator::CityTime do
  let :time do
    Time.new(2000, 1, 2, 3, 4, 5)
  end

  context '#print' do
    it 'without cities' do
      formated_date = 'UTC: 2000-01-02 03:04:05'
      expect(described_class.new('UTC', time).print).to eq(formated_date)
    end

    it 'should return correct date format' do
      expect(described_class.format_date(time)).to eq('2000-01-02 03:04:05')
    end
  end
end
