require 'spec_helper'

RSpec.describe SemaApiRuby::Client::Ocr do

  let(:test_jpg_image_path) { get_test_image_path 'free-shipping-cm.jpg' }
  let(:test_png_image_path) { get_test_image_path 'cfc.png' }

  context '#post_ocr_image' do

    it 'returns 200 OK' do
      expect(api_client.post_ocr_image(test_jpg_image_path).status).to eq 200
    end

    it 'raises Errno::ENOENT for invalid file path' do
      expect { api_client.post_ocr_image('invalid/file/path') }.to raise_error Errno::ENOENT
    end

    it 'returns ocr data' do
      expect(api_client.post_ocr_image(test_jpg_image_path).body).to be_a String
    end

  end

  context '#text_to_image_ratio', :vcr do

    it 'returns close to zero for an image with no text' do
      expect(api_client.text_to_image_ratio(get_test_image_path('no_text.jpg'))).to eq 0.0
    end

    it 'returns the correct ratio for a jpg with a bunch of text' do
      expect(api_client.text_to_image_ratio(get_test_image_path('couches.jpg'))).to eq 0.1441
    end

    it 'returns the correct ratio for a jpg' do
      expect(api_client.text_to_image_ratio(test_jpg_image_path)).to eq 0.4688
    end

    it 'returns the correct ratio for a png' do
      expect(api_client.text_to_image_ratio(test_png_image_path)).to eq 0.0
    end

  end

end
