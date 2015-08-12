module SemaApiRuby

  class GetTextToImageRatio

    attr_accessor :rectangles, :image_size

    def self.call(image_size, rectangles)
      self.new(image_size, rectangles).call
    end

    def initialize(image_size, rectangles)
      @rectangles = rectangles
      @image_size = image_size
    end

    def call
      return 0.0 unless rectangles.any?

      text_area = rectangles.inject(0.0) do |memo, rect|
        memo += if rect['text'].nil? || rect['text'].empty?
          0.0
        else
          (rect['width'] * rect['height']).to_f
        end
      end

      image_area = image_size[0] * image_size[1]

      (text_area / image_area.to_f).round(4)
    end

  end

end
