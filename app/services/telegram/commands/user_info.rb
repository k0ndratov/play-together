# frozen_string_literal: true

module Telegram
  module Commands
    # Command for retrieving user info.
    class UserInfo < Telegram::Commands::Base
      def execute
        user = User.find_by(telegram_id: chat_id)
        return unless user

        text = "Ваш уникальный ID: #{user.id}."
        text += " Ваш никнейм: #{user.username}." if user.username.present?

        send_message(text)
      end
    end
  end
end
