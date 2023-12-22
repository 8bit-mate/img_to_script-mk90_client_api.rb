# frozen_string_literal: true

require "dry/validation"
require "img_to_script"
require "zeitwerk"
require_relative "mk90_client_api/autoloader"
require_relative "mk90_client_api/version"

ImgToScript::MK90ClientAPI::Autoloader.setup

module ImgToScript
  module MK90ClientAPI
    class Error < StandardError; end
    # Your code goes here...

    def self.call(query)
      validation_result = QueryContract.new.call(query)

      validation_result.errors.to_h unless validation_result.success?
    end
  end
end
