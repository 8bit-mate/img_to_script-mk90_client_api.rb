# frozen_string_literal: true

require "dry/validation"
require "img_to_script"
require "zeitwerk"
require_relative "mk90_client_api/autoloader"

ImgToScript::MK90ClientAPI::Autoloader.setup

module ImgToScript
  module MK90ClientAPI
    class Error < StandardError; end
    # Your code goes here...
  end
end
