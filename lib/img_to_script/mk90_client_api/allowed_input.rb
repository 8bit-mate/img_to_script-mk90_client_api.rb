# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Namespace for constants that define allowed input values.
    #
    module AllowedInput
      BASIC_VERSION = %w[
        1.0
        2.0
      ].freeze
      ENCODING_METHOD = %w[
        hex_mask_enhanced
        hex_mask_default
        rle_v
        rle_h
        segmental_direct_v
        segmental_direct_h
        segmental_data_v
        segmental_data_h
      ].freeze
      OUTPUT_FORMAT = %w[
        bas
      ].freeze

      X_OFFSET_MIN = -120
      X_OFFSET_MAX = 120
      Y_OFFSET_MIN = -64
      Y_OFFSET_MAX = 64

      LINE_OFFSET_MIN = 1
      LINE_OFFSET_MAX = 8000 # 8191 is the max. supported by the MK90 BASIC

      LINE_STEP_MIN = 1
      LINE_STEP_MAX = 100
    end
  end
end
