# SemaApiRuby

Ruby client for Sema Media Data's image OCR API. Used for getting an estimated text to image ratio for validating images before being submitted to Facebook Ads.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'sema_api_ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install sema_api_ruby

## Usage

Configure the client by providing an API token. Also tweak the configuration for any of the OCR settings.

```ruby
SemaApiRuby.configure do |config|
  config.access_token = 'myaccesstokenhere'

  #optional - below are the defaults
  config.ocr_settings = {
    lang: 'en',      # english language
    outform: 'json', # output as json
    sp: 'True',      # perform spellcheck
    mh: 'True',      # multi-hypothesis... increases accuracy at slight performance cost
    df: 'True',      # dictionary based word filtering
    noempty: 'True'  # only return detected objects that are not empty
  }
end

```

Post a request to the ocr endpoint with the path to an image to get back a raw response from the api (post made using Faraday gem)
```ruby
client = SemaApiRuby.new
_file_path = '/path/to/your/image.jpg'
client.post_ocr_image(_file_path)
# => #<Faraday::Response:0x007fcb641591e0 ...
```

Use this method to both post to the ocr endpoint and return an text to image ratio
```ruby
client = SemaApiRuby.new
_file_path = '/path/to/your/image.jpg'
client.text_to_image_ratio(_file_path)
# => 0.2123
```

## Contributing

1. Fork it ( https://github.com/[my-github-username]/sema_api_ruby/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
