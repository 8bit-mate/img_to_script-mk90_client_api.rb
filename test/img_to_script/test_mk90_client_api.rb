# frozen_string_literal: true

require_relative "../test_helper"
require "rmagick/bin_magick"

module ImgToScript
  class TestMK90ClientAPI < Minitest::Test
    def read_image
      Magick::BinMagick::Image.from_file(__dir__ << "/data/test_5.png")
    end

    def test_that_it_has_a_version_number
      refute_nil ::ImgToScript::MK90ClientAPI::VERSION
    end

    def test_empty_query
      assert_raises ImgToScript::MK90ClientAPI::QueryError do
        ImgToScript::MK90ClientAPI.call({})
      end
    end

    #
    # Test minimal query - without optional generator & formatter config.
    #
    def test_valid_query_minimal
      image = read_image

      script = ImgToScript::MK90ClientAPI.call(
        {
          basic_version: "1.0",
          encoding_method: "hex_mask_enhanced",
          image: image,
          output_format: "bas"
        }
      )

      assert_equal ["1CLS:DRAWMFF", "2FORI=1TO100:WAIT1024:NEXTI"], script
    end

    def test_valid_query_with_generator_options
      image = read_image

      script = ImgToScript::MK90ClientAPI.call(
        {
          basic_version: "1.0",
          encoding_method: "hex_mask_enhanced",
          image: image,
          output_format: "bas",
          generator_options: {
            y_offset: 10
          }
        }
      )

      assert_equal ["1CLS:DRAWO0,10:DRAWMFF", "2FORI=1TO100:WAIT1024:NEXTI"], script
    end

    def test_valid_query_with_formatter_options
      image = read_image

      script = ImgToScript::MK90ClientAPI.call(
        {
          basic_version: "1.0",
          encoding_method: "hex_mask_enhanced",
          image: image,
          output_format: "bas",
          formatter_options: {
            line_offset: 10,
            line_step: 5
          }
        }
      )

      assert_equal ["10CLS:DRAWMFF", "15FORI=1TO100:WAIT1024:NEXTI"], script
    end

    def test_valid_query_with_generator_and_formatter_options
      image = read_image

      script = ImgToScript::MK90ClientAPI.call(
        {
          basic_version: "1.0",
          encoding_method: "hex_mask_enhanced",
          image: image,
          output_format: "bas",
          generator_options: {
            y_offset: 10
          },
          formatter_options: {
            line_offset: 10,
            line_step: 5
          }
        }
      )

      assert_equal ["10CLS:DRAWO0,10:DRAWMFF", "15FORI=1TO100:WAIT1024:NEXTI"], script
    end
  end
end
