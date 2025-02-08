# frozen_string_literal: true

# Service for fetching popular games from SteamSpy.
#
# This service provides methods to retrieve a list of top games and select a random game name.
class SteamSpyService
  class << self
    def random_game_name
      games = top_games

      games.any? ? [true, games.sample['name']] : [false, 'SteamSpy failed to load popular games']
    end

    def top_games
      url = "#{ENV.fetch('STEAM_SPY_BASE_API')}?request=top100in2weeks"

      response = HTTParty.get(url)

      unless response.success?
        NetworkErrorLogger.log response
        return []
      end

      response.parsed_response.values
    end
  end
end
