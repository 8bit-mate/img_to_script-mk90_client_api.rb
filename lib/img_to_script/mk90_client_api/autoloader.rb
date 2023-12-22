# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Gem's autoloader.
    #
    class Autoloader
      class << self
        def setup
          loader = Zeitwerk::Loader.new #.for_gem
          loader.push_dir(Pathname(__dir__).join("../../")) # lib
          loader.inflector.inflect(
            "mk90_client_api" => "MK90ClientAPI"
          )
          loader.setup
        end
      end
    end
  end
end
