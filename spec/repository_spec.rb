require 'spec_helper'

describe CityRepository do
  subject { described_class.new }

  it '#utc_by_city' do
    expect(subject.utc_by_name('Moscow'))
  end

  it '#utc by_city' do
    expect(subject.utc_by_name('St. Petersburg'))
  end
end
