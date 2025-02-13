# frozen_string_literal: true

# Service class for handling Telegram bot interactions
module Telegram
  class BotService
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

        Telegram::CommandHandler.execute(chat_id, text)
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

      private

      def add_or_update_user(user_info)
        User.from_telegram(user_info)
      end

      def telegram_bot_api_url(endpoint)
        "#{ENV.fetch('TELEGRAM_BASE_API')}/bot#{ENV.fetch('TELEGRAM_BOT_TOKEN')}/#{endpoint}"
      end

      def suggestion_message
        'Did you just send the text? I suggest you try "/random_game_name".'
      end
    end
  end
end
