require 'spec_helper'

RSpec.describe SemaApiRuby::GetTextToImageRatio do

  let(:rectangles) {
     [{"x"=>0, "y"=>294, "width"=>90, "height"=>15, "text"=>"Ii"},
      {"x"=>177, "y"=>292, "width"=>37, "height"=>13, "text"=>""},
      {"x"=>70, "y"=>183, "width"=>251, "height"=>34, "text"=>"FL 1 L R1"},
      {"x"=>368, "y"=>174, "width"=>232, "height"=>43, "text"=>"mm"},
      {"x"=>3, "y"=>98, "width"=>661, "height"=>70, "text"=>"Free Shipping"},
      {"x"=>335, "y"=>73, "width"=>255, "height"=>28, "text"=>"Everyday"},
      {"x"=>379, "y"=>35, "width"=>206, "height"=>29, "text"=>"Low Prices"},
      {"x"=>88, "y"=>22, "width"=>181, "height"=>67, "text"=>"The F"},
      {"x"=>381, "y"=>9, "width"=>205, "height"=>28, "text"=>"EverydaY"}]
  }

  let(:ratio_finder) {
    SemaApiRuby::GetTextToImageRatio.new([800, 600], rectangles)
  }

  it 'returns the correct ratio' do
    expect(ratio_finder.call).to eq 0.2023
  end

end
