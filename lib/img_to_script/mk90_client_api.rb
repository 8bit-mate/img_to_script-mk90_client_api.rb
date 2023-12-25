# frozen_string_literal: true

require "dry/validation"
require "img_to_script"
require "zeitwerk"
require_relative "mk90_client_api/autoloader"
require_relative "mk90_client_api/version"

ImgToScript::MK90ClientAPI::Autoloader.setup

module ImgToScript
  #
  # Provides an API between a img_to_mk90_bas client app,
  # and the img_to_script lib.
  #
  module MK90ClientAPI
    class Error < StandardError; end

    class QueryError < Error; end

    #
    # <Description>
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
