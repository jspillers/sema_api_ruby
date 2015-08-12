require 'faraday'
require 'faraday_middleware'
require 'fastimage'
require 'sema_api_ruby/client/ocr'

module SemaApiRuby

  class Client

    include SemaApiRuby::Client::Ocr

    # setup accessors on this client for all config keys
    attr_accessor *Configuration::VALID_CONFIG_KEYS

    def initialize(options = {})
      # Use options passed in, but fall back to config module defaults
      merged_options = SemaApiRuby.options.merge(options)

      # Copy the merged values to this client and ignore those
      # not part of our configuration
      SemaApiRuby::Configuration::VALID_CONFIG_KEYS.each do |key|
        public_send("#{key}=", merged_options[key])
      end

      if access_token.nil?
        raise NoTokenError, 'you must provide an access token'
      end
    end

    private

    def conn
      @conn ||= Faraday.new(url: api_endpoint) do |conn|
        conn.request :multipart
        conn.request :url_encoded
        #conn.response :json

        conn.adapter Faraday.default_adapter
      end
    end

    def conn_with_auth
      @conn_with_auth ||= begin
        conn.headers['X-api-key'] = access_token
        conn.headers['User-Agent'] = user_agent
        conn.headers['Content-Type'] = content_type
        conn
      end
    end

    def mime_type(_file_path)
      "image/#{FastImage.type(_file_path)}"
    end

    def image_size(_file_path)
      FastImage.size(_file_path)
    end

  end

end
