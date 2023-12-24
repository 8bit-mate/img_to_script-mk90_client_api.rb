# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Resizes the image and converts to binary.
    #
    class ImageProcessor
      #
      # Call image processor.
      #
      # @param [Magick::BinMagick::Image] image
      # @param [Hash{ Symbol => Object }] kwargs
      #
      # @return [Magick::BinMagick::Image] @image
      #
      def call(image:, **kwargs)
        _call(
          image: image,
          scr_width: ImgToScript::Languages::MK90Basic::SCR_WIDTH,
          scr_height: ImgToScript::Languages::MK90Basic::SCR_HEIGHT,
          **kwargs
        )
      end

      private

      #
      # Call image processor.
      #
      # @param [Magick::BinMagick::Image] image
      # @param [Integer] scr_width
      # @param [Integer] scr_height
      #
      # @return [Magick::BinMagick::Image] @image
      #
      def _call(image:, scr_width:, scr_height:, **kwargs)
        @image = image

        _resize_image(scr_width, scr_height) if @image.oversize?(scr_width, scr_height)
        _to_binary(**kwargs) unless @image.binary?

        @image
      end

      #
      # Forcibly resize the image if it doesn't fit to the device's screen resolution.
      #
      def _resize_image(width, height)
        @image.fit_to_size!(width, height)
      end

      #
      # Forcibly convert to binary.
      #
      def _to_binary(**kwargs)
        if kwargs[:to_binary_params]
          # Convert with custom params [n_gray_colors, quantize_dither, threshold_map]
          @image.to_binary!(kwargs[:to_binary_params])
        else
          # Convert with default params.
          @image.to_binary!
        end
      end
    end
  end
end
