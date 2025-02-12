# frozen_string_literal: true

module Telegram
  class CommandHandler
    class << self
      def execute(chat_id, command_text)
        command, params = command_text.split(' ', 2)
        command_class = commands[command] || Telegram::Commands::Unknown
        command_class.new(chat_id, params).execute
      end

      def register(command_text, command_class)
        commands[command_text] = command_class
      end

      private

      def commands
        @commands ||= {}
      end
    end
  end
end
