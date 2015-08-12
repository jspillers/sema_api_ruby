require 'spec_helper'

RSpec.describe SemaApiRuby do

  it 'has a version number' do
    expect(SemaApiRuby::VERSION).not_to be nil
  end

  it '#new returns a client instance' do
    expect(SemaApiRuby.new(access_token: '1234')).to be_a SemaApiRuby::Client
  end

  it '#new raises an error when no access token is provided' do
    expect { SemaApiRuby.new }.to raise_error SemaApiRuby::Client::NoTokenError
  end

end
