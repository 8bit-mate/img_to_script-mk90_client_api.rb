# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Handles query.
    #
    class QueryHandler
      #
      # Handle query:
      # 1. validate input query;
      # 2. if query is correct: configure and call an ImgToScript
      #    task instance;
      # 3. return result of the ImgToScript::Task call.
      #
      # @param [Hash{ Symbol => Object }, Hash{ String => Object }] query
      #
      # @return [Array<String>]
      #   Generated BASIC script.
      #
      def call(query)
        valid_query = _validate_input(query)

        task = _init_task(valid_query)

        image = _prepare_image(
          _read_image(valid_query[:image], valid_query[:image_type])
        )

        task.run(
          image: image,
          scr_width: ImgToScript::Languages::MK90Basic::SCR_WIDTH,
          scr_height: ImgToScript::Languages::MK90Basic::SCR_HEIGHT
        )
      end

      private

      #
      # Validate input query.
      #
      # @param [Hash{ Symbol => Object }, Hash{ String => Object }] query
      #
      # @return [Hash{ Symbol => Object }] result.schema_result.output
      #
      # @raise [ImgToScript::MK90ClientAPI::QueryError]
      #
      def _validate_input(query)
        result = QueryContract.new.call(query)

        raise QueryError, result.errors.to_h.first.join(": ") unless result.success?

        result.schema_result.output
      end

      #
      # Read image from the query.
      #
      # @param [String, BinMagick::Image] image_object
      #   Base64 string or BinMagick::Image.
      #
      # @param [String] image_type
      #   Defines image type.
      #
      # @return [BinMagick::Image]
      #
      def _read_image(image_object, image_type)
        case image_type
        when "base64"
          _base64_to_img(image_object)
        when "bin_magick"
          image_object
        end
      end

      #
      # Convert a base64-encoded string into a BinMagick image object.
      #
      # @param [String] base64_str
      #
      # @return [Magick::BinMagick::Image]
      #
      def _base64_to_img(base64_str)
        Magick::BinMagick::Image.new(
          Magick::Image.read_inline(base64_str).first
        )
      end

      #
      # Prepare the image: resize and convert to binary.
      #
      # @param [Magick::BinMagick::Image] image
      #   Original image.
      #
      # @return [Magick::BinMagick::Image]
      #   Edited image.
      #
      def _prepare_image(image)
        ImageProcessor.new.call(image: image)
      end

      #
      # Init. and configure a comvertion task.
      #
      # @param [Hash{ String => Object}] query
      #
      # @return [ImgToScript::Task] task
      #   Configured task object.
      #
      def _init_task(query)
        @generator = _init_generator(query[:encoding_method])
        translator = _init_translator(query[:basic_version])
        @formatter = _init_formatter

        _configure_generator(query[:generator_options]) if query[:generator_options]
        _configure_formatter(query[:formatter_options]) if query[:formatter_options]

        ImgToScript::Task.new(
          generator: @generator,
          translator: translator,
          formatter: @formatter
        )
      end

      #
      # Init. generator object
      #
      # @param [String] name
      #
      # @return [Object]
      #
      def _init_generator(name)
        case name
        when "hex_mask_enhanced"
          ImgToScript::Generators::HexMask::Enhanced.new
        when "hex_mask_default"
          ImgToScript::Generators::HexMask::Default.new
        when "rle_v"
          ImgToScript::Generators::RunLengthEncoding::Vertical.new
        when "rle_h"
          ImgToScript::Generators::RunLengthEncoding::Horizontal.new
        when "segmental_direct_v"
          ImgToScript::Generators::Segmental::DirectDraw::Vertical.new
        when "segmental_direct_h"
          ImgToScript::Generators::Segmental::DirectDraw::Horizontal.new
        when "segmental_data_v"
          ImgToScript::Generators::Segmental::DataReadDraw::Vertical.new
        when "segmental_data_h"
          ImgToScript::Generators::Segmental::DataReadDraw::Horizontal.new
        end
      end

      #
      # Init. translator object
      #
      # @param [String] basic_version
      #
      # @return [Object]
      #
      def _init_translator(basic_version)
        case basic_version
        when "1.0"
          ImgToScript::Languages::MK90Basic::Translators::MK90Basic10.new
        when "2.0"
          ImgToScript::Languages::MK90Basic::Translators::MK90Basic20.new
        end
      end

      def _init_formatter
        ImgToScript::Languages::MK90Basic::Formatters::Minificator.new
      end

      #
      # Configure @generator object.
      #
      # @param [Hash{ Symbol => Object }] params
      #
      def _configure_generator(params)
        @generator.configure do |config|
          params.each { |key, value| config.send("#{key}=", value) }
        end
      end

      #
      # Configure @formatter object.
      #
      # @param [Hash{ Symbol => Object }] params
      #
      def _configure_formatter(params)
        @formatter.configure do |config|
          params.each { |key, value| config.send("#{key}=", value) }
        end
      end
    end
  end
end
