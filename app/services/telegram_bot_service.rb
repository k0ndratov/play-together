# frozen_string_literal: true

# Service for handling Telegram bot commands and sending messages.
#
# This service provides methods to process incoming messages, determine if they
# are commands, and execute appropriate actions based on the command received.
class TelegramBotService
  class << self
    def command?(text)
      text.start_with?('/')
    end

    def process_command(command_params)
      message = command_params[:message]
      return if message.blank?

      user_info = message[:from]
      add_or_update_user(user_info)

      text = message[:text]
      chat_id = message[:chat][:id]

      return send_message(chat_id, suggestion_message) unless command?(text)

      execute_command(text, chat_id)
    end

    private

    def add_or_update_user(user_info)
      User.from_telegram(user_info)
    end

    def send_message(chat_id, text)
      url = telegram_bot_api_url('sendMessage')
      response = HTTParty.post(
        url,
        body: { chat_id:, text: }.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
      NetworkErrorLogger.log response unless response.success?
    end

    def execute_command(command, chat_id)
      case command
      when '/random_game_name'
        random_game_name_action(chat_id)
      when '/user_info'
        user_info_action(chat_id)
      else
        send_message(chat_id, unknown_command_message)
      end
    end

    def random_game_name_action(chat_id)
      success, name = SteamSpyService.random_game_name

      send_message(chat_id, name) if success
    end

    def user_info_action(chat_id)
      user = User.find_by(telegram_id: chat_id)

      return unless user

      text = "Ваш уникальный ID: #{user.id}."
      text += " Ваш никнейм: #{user.username}." if user.username.present?

      send_message(chat_id, text)
    end

    def telegram_bot_api_url(endpoint)
      "#{ENV.fetch('TELEGRAM_BASE_API')}/bot#{ENV.fetch('TELEGRAM_BOT_TOKEN')}/#{endpoint}"
    end

    def suggestion_message
      'Did you just send the text? I suggest you try "/random_game_name".'
    end

    def unknown_command_message
      'Unknown command.'
    end
  end
end
