module SemaApiRuby

  module Configuration

    VALID_CONFIG_KEYS = [
      :access_token,
      :api_endpoint,
      :api_version,
      :user_agent,
      :format,
      :content_type,
      :debug_output
    ]

    DEFAULT_API_ENDPOINT = 'https://semamediadata.com/api'.freeze # 1.0/ocr/
    DEFAULT_API_VERSION  = 1.0
    DEFAULT_USER_AGENT   = "SemaApiRuby Gem #{SemaApiRuby::VERSION}".freeze
    DEFAULT_FORMAT       = :json
    DEFAULT_CONTENT_TYPE = 'multipart/form-data'
    DEFAULT_DEBUG_OUTPUT = false # $stdout

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
      self.format        = DEFAULT_FORMAT
      self.content_type  = DEFAULT_CONTENT_TYPE
      self.debug_output  = DEFAULT_DEBUG_OUTPUT
    end

  end

end
