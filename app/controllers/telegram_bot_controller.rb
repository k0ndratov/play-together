# frozen_string_literal: true

# Controller for handling incoming Telegram bot webhook requests.
#
# This controller processes messages received from Telegram and delegates command
# execution to `TelegramBotService`.
class TelegramBotController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:webhook]

  def webhook
    TelegramBotService.process_command(params)
    head :ok
  end
end
