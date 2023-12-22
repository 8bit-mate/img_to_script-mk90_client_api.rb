# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Sets rules for the formatter options input data.
    #
    class FormatterOptionsContract < AppContract
      params do
        optional(:line_offset).value(
          :integer,
          gt?: AllowedInput::LINE_OFFSET_MIN,
          lt?: AllowedInput::LINE_OFFSET_MAX
        )
        optional(:line_step).value(
          :integer,
          gt?: AllowedInput::LINE_STEP_MIN,
          lt?: AllowedInput::LINE_STEP_MAX
        )
      end
    end
  end
end
