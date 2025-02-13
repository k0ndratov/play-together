# frozen_string_literal: true

module Telegram
  module Commands
    # Fallback command for unknown inputs.
    class Unknown < Telegram::Commands::Base
      def execute
        send_message('Unknown command.')
      end
    end
  end
end
