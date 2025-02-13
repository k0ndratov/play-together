# frozen_string_literal: true

RSpec.describe Telegram::Commands::Unknown do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id, nil).execute
    end

    let(:chat_id) { 1 }
    let(:command_text) { '/some_unknown_command' }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end
    let!(:send_unknown_message_stub) do
      stub_request(:post, send_message_api)
        .with(body: {
          chat_id: chat_id,
          text: 'Unknown command.'
        }.to_json)
        .to_return(status: 200)
    end

    it 'sends an unknown message' do
      execute
      expect(send_unknown_message_stub).to have_been_requested.once
    end
  end
end
