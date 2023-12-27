# frozen_string_literal: true

require "base64"
require "dry/validation"
require "img_to_script"
require "rmagick"
require "rmagick/bin_magick"
require "zeitwerk"

require_relative "mk90_client_api/autoloader"
require_relative "mk90_client_api/version"

ImgToScript::MK90ClientAPI::Autoloader.setup

module ImgToScript
  #
  # Provides an API between an img_to_mk90_bas client app,
  # and the img_to_script lib.
  #
  module MK90ClientAPI
    class Error < StandardError; end

    class QueryError < Error; end

    class InvalidImage < Error; end

    #
    # Generate BASIC program by calling the img_to_script gem.
    #
    # @param [Hash{ Symbol => Object}, Hash{ String => Object }] query
    #
    # @return [Array<String>]
    #
    def self.call(query)
      QueryHandler.new.call(query)
    end
  end
end
