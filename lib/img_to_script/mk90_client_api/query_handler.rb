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
    end
  end
end
