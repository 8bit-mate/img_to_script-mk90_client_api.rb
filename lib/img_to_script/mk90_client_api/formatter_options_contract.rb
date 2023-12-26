# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Sets rules for the formatter options input data.
    #
    class FormatterOptionsContract < AppContract
      json do
        optional(:line_offset).value(
          :integer,
          gteq?: AllowedInput::LINE_OFFSET_MIN,
          lteq?: AllowedInput::LINE_OFFSET_MAX
        )
        optional(:line_step).value(
          :integer,
          gteq?: AllowedInput::LINE_STEP_MIN,
          lteq?: AllowedInput::LINE_STEP_MAX
        )
      end
    end
  end
end
