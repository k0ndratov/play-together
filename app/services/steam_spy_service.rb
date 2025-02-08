# frozen_string_literal: true

class SteamSpyService
  require 'net/http'
  require 'json'

  BASE_API_URL = 'https://steamspy.com/api.php'

  def self.random_game_name
    games = top_games

    games.to_a.sample[1]['name'] unless games.nil?
  end

  def self.top_games
    uri = URI("#{BASE_API_URL}?request=top100in2weeks")
    begin
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    rescue StandardError => e
      Rails.logger.error("Steamspy API request failed: #{e.message}")
      nil
    end
  end
end
