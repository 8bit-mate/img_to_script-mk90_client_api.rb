# img_to_script-mk90_client_api

Provides a handy API between an img_to_mk90_bas application and the **[img_to_script](https://github.com/8bit-mate/img_to_script.rb)** gem. Instead of working with the img_to_script objects directly, just pass a hash with parameters to the img_to_script-mk90_client_api. This is handy when you get the parameters as a JSON string, e.g. from a web front-end.

## Installation

Add this line to your application's Gemfile:

```ruby
gem "img_to_script-mk90_client_api"
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install img_to_script-mk90_client_api

## Usage

ImgToScript::MK90ClientAPI.call(query) -> Array\<String\>

### Argument

**query**: hash with parameters.

### Returns

Generated BASIC program.

### Raises

- **ImgToScript::MK90ClientAPI::QueryError**

  A key is missing, has a value of an unsupported type, or has an illegal value.

- **ImgToScript::MK90ClientAPI::InvalidImage**

  Invalid image: the image can't be decoded from the base64 string.
  
## Query description

| Key           | Type          | Necessity | Description   | Allowed values
| ------------- | ------------- | --------- | ------------- | ---------------
| :basic_version | String | Required | Defines target BASIC version | <ul><li>1.0</li><li>2.0</li></ul>
| :encoding_method | String | Required | Defines target encoding method | <ul><li>hex_mask_enhanced</li><li>hex_mask_default</li><li>rle_v</li><li>rle_h</li><li>segmental_direct_v</li><li>segmental_direct_h</li><li>segmental_data_v</li><li>segmental_data_h</li></ul>
| :image | String | Required | Image to convert | A base64-encoded image
| :output_format | String |  Required | Defines output format | <ul><li>bas</li></ul>
| :generator_options | Hash{ Symbol => Object } |  Optional | Defines script generator options | -
| :formatter_options | Hash{ Symbol => Object } |  Optional | Defines script formatter options | -

### Generator options

| Key           | Type          | Necessity | Description   | Allowed values
| ------------- | ------------- | --------- | ------------- | ---------------
| :x_offset | Integer | Optional | Defines image horizontal offset | -120..120
| :y_offset | Integer | Optional | Defines image vertical offset | -64..64
| :clear_screen | Boolean | Optional | Add a clear screen statement | true/false
| :pause_program | Boolean |  Optional | Add a pause statement | true/false

### Formatter options

| Key           | Type          | Necessity | Description   | Allowed values
| ------------- | ------------- | --------- | ------------- | ---------------
| :line_offset | Integer | Optional | Defines first BASIC line offset | 1..8000
| :line_step | Integer | Optional | Defines step between BASIC lines | 1..100

## Usage example

```ruby
require "img_to_script/mk90_client_api"
require "rmagick"
require "rmagick/bin_magick"

def self.read_image(filename)
  img = Magick::BinMagick::Image.from_file(filename)
  img.colorspace = Magick::GRAYColorspace
  Base64.strict_encode64(
    img.to_blob
  )
end

script = ImgToScript::MK90ClientAPI.call(
  {
    basic_version: "1.0",
    encoding_method: "hex_mask_enhanced",
    image: read_image("my_image.png"),
    output_format: "bas",
    generator_options: {
      x_offset: -5,
      y_offset: -10
    },
    formatter_options: {
      line_offset: 10,
      line_step: 5
    }
  }
)

puts script
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake test` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/8bit-mate/img_to_script-mk90_client_api.rb.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
