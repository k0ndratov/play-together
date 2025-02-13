# frozen_string_literal: true

module Telegram
  # Handles the execution of different Telegram bot commands
  class CommandHandler
    COMMANDS = {
      '/random_game_name' => Telegram::Commands::RandomGameName,
      '/user_info' => Telegram::Commands::UserInfo,
      '/create_party' => Telegram::Commands::CreateParty
    }.freeze

    class << self
      def execute(chat_id, command_text)
        command, params = command_text.split(' ', 2)

        command_class = COMMANDS[command] || Telegram::Commands::Unknown
        command_class.new(chat_id, params).execute
      end
    end
  end
end
