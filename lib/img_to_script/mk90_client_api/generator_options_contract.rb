# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Sets rules for the generator options input data.
    #
    class GeneratorOptionsContract < AppContract
      params do
        optional(:x_offset).value(
          :integer,
          gt?: AllowedInput::X_OFFSET_MIN,
          lt?: AllowedInput::X_OFFSET_MAX
        )
        optional(:y_offset).value(
          :integer,
          gt?: AllowedInput::Y_OFFSET_MIN,
          lt?: AllowedInput::Y_OFFSET_MAX
        )
        optional(:clear_screen).value(:bool)
        optional(:pause_program).value(:bool)
      end
    end
  end
end
