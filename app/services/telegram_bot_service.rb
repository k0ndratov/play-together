# frozen_string_literal: true

class TelegramBotService
  BASE_API_URL = 'https://api.telegram.org'

  def self.send_message(chat_id, text)
    uri = URI(telegram_bot_api_url('sendMessage'))
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(uri, { 'Content-Type' => 'application/json' })
    request.body = { chat_id: chat_id, text: text }.to_json

    begin
      # FIXME: 404 не ошибка?
      http.request(request)
    rescue StandardError => e
      Rails.logger.error("Telegram API request failed: #{e.message}")
    end
  end

  def self.command?(text)
    text.start_with?('/')
  end

  def self.telegram_bot_api_url(endpoint)
    "#{BASE_API_URL}/bot#{ENV.fetch('TELEGRAM_BOT_TOKEN')}/#{endpoint}"
  end
end
