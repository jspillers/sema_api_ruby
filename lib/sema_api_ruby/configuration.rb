module SemaApiRuby

  module Configuration

    VALID_CONFIG_KEYS = [
      :access_token,
      :api_endpoint,
      :api_version,
      :user_agent,
      :content_type,
      :ocr_settings,
      :debug_output
    ]

    DEFAULT_API_ENDPOINT = 'https://semamediadata.com/api'.freeze # 1.0/ocr/
    DEFAULT_API_VERSION  = 1.0
    DEFAULT_USER_AGENT   = "SemaApiRuby Gem #{SemaApiRuby::VERSION}".freeze
    DEFAULT_CONTENT_TYPE = 'multipart/form-data'
    DEFAULT_DEBUG_OUTPUT = false # $stdout

    DEFAULT_OCR_SETTINGS = {
      lang: 'en',      # english language
      outform: 'json', # output as json
      sp: 'True',      # perform spellcheck
      mh: 'True',      # multi-hypothesis... increases accuracy at slight performance cost
      df: 'True',      # dictionary based word filtering
      noempty: 'True'  # only return detected objects that are not empty
    }

    attr_accessor *VALID_CONFIG_KEYS

    def configure
      yield self
    end

    def self.extended(base)
      base.reset
    end

    def options
      Hash[ *VALID_CONFIG_KEYS.map { |key| [key, public_send(key)] }.flatten ]
    end

    def reset
      self.access_token  = nil
      self.api_endpoint  = DEFAULT_API_ENDPOINT
      self.api_version   = DEFAULT_API_VERSION
      self.user_agent    = DEFAULT_USER_AGENT
      self.content_type  = DEFAULT_CONTENT_TYPE
      self.debug_output  = DEFAULT_DEBUG_OUTPUT
      self.ocr_settings  = DEFAULT_OCR_SETTINGS
    end

  end

end
