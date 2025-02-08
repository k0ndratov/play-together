# frozen_string_literal: true

RSpec.describe TelegramBotService do
  let(:send_message_api) { "https://api.telegram.org/bot#{ENV['TELEGRAM_BOT_TOKEN']}/sendMessage" }
  let(:chat_id) { 1234 }
  let(:text) { 'Hello world' }

  describe '.send_message' do
    context 'when request is successful' do
      before do
        stub_request(:post, send_message_api).to_return(status: 200)
      end

      it 'sends message to telegram bot' do
        described_class.send_message(chat_id, text)

        expect(WebMock).to have_requested(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: text }.to_json)
          .once
      end
    end

    context 'when request fails' do
      before do
        stub_request(:post, send_message_api).to_return(status: 500)
      end

      it 'does not raise error' do
        expect do
          described_class.send_message(chat_id, text)
        end.not_to raise_error
      end
    end
  end

  describe '.command?' do
    context 'when text starts with /' do
      it 'returns true' do
        expect(described_class.command?('/command')).to be true
      end
    end

    context 'when text does not start with /' do
      it 'returns false' do
        expect(described_class.command?('not command')).to be false
      end
    end
  end
end
