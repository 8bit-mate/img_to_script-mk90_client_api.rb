# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Base class for validation contracts.
    #
    class AppContract < Dry::Validation::Contract
      config.messages.default_locale = :en
    end
  end
end
