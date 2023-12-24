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
      # @param [Hash{ String => Object}] query
      #
      # @return [Array<String>]
      #   Generated BASIC script.
      #
      def call(query)
        _validate_input(query)

        task = _configure_task(query)

        task.run(
          image: _prepare_image(query[:image]),
          scr_width: ImgToScript::Languages::MK90Basic::SCR_WIDTH,
          scr_height: ImgToScript::Languages::MK90Basic::SCR_HEIGHT
        )
      end

      private

      #
      # Validate input query.
      #
      # @param [Hash{ String => Object}] query
      #
      # @return [Hash{ String => Object}] query
      #   Unmodified query if it passed all validations.
      #
      # @raise [ImgToScript::MK90ClientAPI::QueryError]
      #
      def _validate_input(query)
        result = QueryContract.new.call(query)

        raise QueryError, result.errors.to_h.first.join(": ") unless result.success?

        query
      end

      def _prepare_image(image)
        ImageProcessor.new.call(image: image)
      end

      #
      # Configure comvertion task.
      #
      # @param [Hash{ String => Object}] query
      #
      # @return [ImgToScript::Task] task
      #   Configured task object.
      #
      def _configure_task(query)
        @generator = _init_generator(query[:encoding_method])
        translator = _init_translator(query[:basic_version])
        @formatter = _init_formatter

        ImgToScript::Task.new(
          generator: @generator,
          translator: translator,
          formatter: @formatter
        )
      end

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

      def _configure_generator(params)
        @generator.configure do |config|
          params.each { |key, value| config.send("#{key}=", value) }
        end
      end

      def _configure_formatter(params)
        @formatter.configure do |config|
          params.each { |key, value| config.send("#{key}=", value) }
        end
      end
    end
  end
end
