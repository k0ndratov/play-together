# frozen_string_literal: true

module Telegram
  module Commands
    # Command for sending a random game name.
    class RandomGameName < Telegram::Commands::Base
      def execute
        success, name = SteamSpyService.random_game_name
        send_message(name) if success
      end
    end
  end
end
