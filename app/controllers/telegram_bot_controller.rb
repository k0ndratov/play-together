# frozen_string_literal: true

class TelegramBotController < ApplicationController
  BASE_API_URL = 'https://api.telegram.org'

  skip_before_action :verify_authenticity_token, only: [:webhook]

  def webhook
    message = params[:message]

    return head :ok if message.blank? || !TelegramBotService.command?(message[:text])

    text = message[:text]
    chat_id = message[:chat][:id]

    case text
    when '/random_game_name'
      name = SteamSpyService.random_game_name
      TelegramBotService.send_message(chat_id, name)
    else
      TelegramBotService.send_message(chat_id, 'Unknown command.')
    end

    head :ok
  end
end
