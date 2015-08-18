require 'json'

module SemaApiRuby

  class Client

    module Ocr

      def text_to_image_ratio(_file_path)
        response = post_ocr_image(_file_path)

        body = JSON.parse(response.body)

        raise SemaApiRuby::Client::EmptyResponse unless body['frames']

        return 0.0 if body['frames'].empty?

        rectangles = body['frames'].first['results']

        SemaApiRuby::GetTextToImageRatio.call(image_size(_file_path), rectangles)

      # workaround for bug in sema media api where they are returning invalid json
      # when an image does not have any text results. Remove when they start returning
      # valid json
      rescue JSON::ParserError => e
        if e.message =~ /unexpected token at '(\]\})+'/
          0.0
        else
          raise e
        end
      end

      def post_ocr_image(_file_path)
        post_body = ocr_settings.merge(
          file: Faraday::UploadIO.new(_file_path, mime_type(_file_path))
        )
        conn_with_auth.post("/api/#{api_version}/ocr/", post_body)
      end

    end

  end

end
