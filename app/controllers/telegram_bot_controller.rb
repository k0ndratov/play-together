class TelegramBotController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [ :webhook ]

  def webhook
    head :ok
  end
end
