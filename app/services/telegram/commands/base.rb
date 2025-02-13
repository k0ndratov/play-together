# frozen_string_literal: true

module Telegram
  module Commands
    # Abstract base class for Telegram bot commands.
    class Base
      attr_reader :chat_id, :params

      def initialize(chat_id)
        @chat_id = chat_id
      end

      def execute
        raise NotImplementedError, "#{self.class}#execute must be implemented"
      end

      private

      def send_message(text)
        Telegram::BotService.send_message(chat_id, text)
      end
    end
  end
end
