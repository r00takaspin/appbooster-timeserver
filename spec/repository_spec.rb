require 'spec_helper'

describe CityRepository do
  subject { described_class.new }

  it '#utc_by_city' do
    expect(subject.utc_by_name('Moscow'))
  end

  context '#utc by_city' do
    it 'single word' do
      expect(subject.utc_by_name('Moscow')).to eq('Europe/Moscow')
    end

    it 'two words' do
      expect(subject.utc_by_name('St. Petersburg')).to eq('Europe/Moscow')
    end
  end
end
