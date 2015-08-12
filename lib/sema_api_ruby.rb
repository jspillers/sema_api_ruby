require 'sema_api_ruby/version'
require 'sema_api_ruby/configuration'
require 'sema_api_ruby/exceptions'
require 'sema_api_ruby/get_text_to_image_ratio'
require 'sema_api_ruby/client'

module SemaApiRuby

  extend Configuration

  def self.new(options = {})
    SemaApiRuby::Client.new(options)
  end

  def self.root
    File.dirname __dir__
  end

  def self.default_ocr_options
    {
      lang: 'en',      # english language
      outform: 'json', # output as json
      sp: 'True',      # perform spellcheck
      mh: 'True',      # multi-hypothesis... increases accuracy at slight performance cost
      df: 'True',      # dictionary based word filtering
      noempty: 'True'  # only return detected objects that are not empty
    }
  end

end
