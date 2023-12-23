# frozen_string_literal: true

module ImgToScript
  module MK90ClientAPI
    #
    # Handles query.
    #
    class QueryHandler
      #
      # <Description>
      #
      # @param [<Type>] query <description>
      #
      # @return [<Type>] <description>
      #
      def call(query)
        _validate_input(query)
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
      # @raise [ArgumentError]
      #
      def _validate_input(query)
        result = QueryContract.new.call(query)

        raise ArgumentError, result.errors.to_h.first.join(": ") unless result.success?

        query
      end
    end
  end
end
