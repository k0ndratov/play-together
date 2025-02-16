# frozen_string_literal: true

module Telegram
  module Commands
    class RandomGameName < Telegram::Commands::Base
      command '/random_game_name'

      def execute
        success, name = SteamSpyService.random_game_name
        send_message(name) if success
      end
    end
  end
end
