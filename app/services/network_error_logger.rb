# frozen_string_literal: true

# Service for logging errors from HTTParty.
#
# This service logs failed API requests, providing details about the response code and body.
class NetworkErrorLogger
  class << self
    def log(response)
      Rails.logger.error("API request failed: #{response.code} - #{response.body}")
    end
  end
end
