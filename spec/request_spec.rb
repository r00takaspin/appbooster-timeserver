require 'spec_helper'

describe Request do
  # HACK: spoof unix socket with file descriptor
  subject { described_class.new(File.open('./spec/fixtures/http_request.txt')) }

  it 'should return correct path' do
    expect(subject.path).to eq('/time?Kaliningrad')
  end

  it 'params' do
    expect(subject.params).to eq('Kaliningrad')
  end
end
