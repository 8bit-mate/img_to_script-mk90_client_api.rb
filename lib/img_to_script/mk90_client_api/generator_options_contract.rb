# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Sets rules for the generator options input data.
    #
    class GeneratorOptionsContract < AppContract
      json do
        optional(:x_offset).value(
          :integer,
          gteq?: AllowedInput::X_OFFSET_MIN,
          lteq?: AllowedInput::X_OFFSET_MAX
        )
        optional(:y_offset).value(
          :integer,
          gteq?: AllowedInput::Y_OFFSET_MIN,
          lteq?: AllowedInput::Y_OFFSET_MAX
        )
        optional(:clear_screen).value(:bool)
        optional(:pause_program).value(:bool)
      end
    end
  end
end
