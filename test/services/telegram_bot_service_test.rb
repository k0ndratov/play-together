class TelegramBotServiceTest < ActiveSupport::TestCase
  def setup
    @send_message_api = "https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage"
    @chat_id = 1234
    @text = "Hello world"
  end

  test "shoud send request message to telegram bot" do
    stub_request(:post, @send_message_api)
      .to_return(status: 200)

    TelegramBotService.send_message(@chat_id, @text)

    assert_requested(:post, @send_message_api, times: 1) do |req|
      req.body == { chat_id: @chat_id, text: @text }.to_json
    end
  end

  test "shoud return nothing if the request to telegram api failed" do
    stub_request(:post, @send_message_api)
      .to_return(status: 500)

    assert_nothing_raised do
      TelegramBotService.send_message(@chat_id, @text)
    end
  end
end
