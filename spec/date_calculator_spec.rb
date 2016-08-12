require 'spec_helper'

describe DateCalculator do
  let :time do
    Time.new(2000, 1, 2, 3, 4, 5)
  end

  context '#format_date' do
    it 'with give cities' do
      result_arr = ['UTC: 2000-01-02 03:04:05', 'Moscow: 2000-01-02 06:04:05']
      result_text = result_arr.join("\n")
      expect(described_class.new(time, ['Moscow']).print).to eq(result_text)
    end
  end
end
