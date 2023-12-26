# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Sets rules for the query input data.
    #
    class QueryContract < AppContract
      json do
        required(:basic_version).value(:string, included_in?: AllowedInput::BASIC_VERSION)
        required(:encoding_method).value(:string, included_in?: AllowedInput::ENCODING_METHOD)
        required(:image).value(:string)
        required(:output_format).value(:string, included_in?: AllowedInput::OUTPUT_FORMAT)

        optional(:generator_options).hash(GeneratorOptionsContract.schema)
        optional(:formatter_options).hash(FormatterOptionsContract.schema)
      end

      rule(:image) do
        key.failure("not a valid base64 string") unless _base64?(value)
      end

      private

      def _base64?(value)
        value.is_a?(String) && Base64.strict_encode64(Base64.decode64(value)) == value
      end
    end
  end
end
