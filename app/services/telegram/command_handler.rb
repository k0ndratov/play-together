# frozen_string_literal: true

module Telegram
  # Handles the execution of different Telegram bot commands
  class CommandHandler
    COMMANDS = {
      '/random_game_name' => Telegram::Commands::RandomGameName,
      '/user_info' => Telegram::Commands::UserInfo
    }.freeze

    class << self
      def execute(chat_id, command_text)
        command_class = COMMANDS[command_text] || Telegram::Commands::Unknown
        command_class.new(chat_id).execute
      end
    end
  end
end
