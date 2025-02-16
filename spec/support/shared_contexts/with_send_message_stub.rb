# frozen_string_literal: true

TELEGRAM_SEND_MESSAGE_API = 'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'

RSpec.shared_context 'with send message stub' do
  def send_message_stub(chat_id, text, status = 200)
    stub_request(:post, TELEGRAM_SEND_MESSAGE_API)
      .with(body: { chat_id:, text: }.to_json)
      .to_return(status: status)
  end
end
