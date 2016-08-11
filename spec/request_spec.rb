require 'spec_helper'

describe Request do
  # HACK: вместо стрима сокета подсовываем дескриптом открытого файла
  subject { described_class.new(File.open('./spec/fixtures/http_request.txt')) }

  it 'should return correct path' do
    expect(subject.path).to eq('/time?Kaliningrad')
  end

  it 'params' do
    expect(subject.params).to eq('Kaliningrad')
  end
end