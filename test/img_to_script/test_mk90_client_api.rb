# frozen_string_literal: true

require "test_helper"

module ImgToScript
  class TestMK90ClientAPI < Minitest::Test
    def test_that_it_has_a_version_number
      refute_nil ::ImgToScript::MK90ClientAPI::VERSION
    end

    def test_empty_query
      ImgToScript::MK90ClientAPI.call(
        {}
      )
    end
  end
end
