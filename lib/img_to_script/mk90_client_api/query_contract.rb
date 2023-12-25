# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    class QueryContract < AppContract
      params do
        required(:basic_version).value(:string, included_in?: AllowedInput::BASIC_VERSION)
        required(:encoding_method).value(:string, included_in?: AllowedInput::ENCODING_METHOD)
        required(:image)
        required(:image_type).value(:string, included_in?: AllowedInput::IMAGE_TYPE)
        required(:output_format).value(:string, included_in?: AllowedInput::OUTPUT_FORMAT)

        optional(:generator_options).hash(GeneratorOptionsContract.schema)
        optional(:formatter_options).hash(FormatterOptionsContract.schema)
      end
    end
  end
end
