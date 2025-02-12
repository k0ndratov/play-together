# frozen_string_literal: true

RSpec.describe Telegram::Commands::AllParties do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id, nil).execute
    end

    let(:chat_id) { 1 }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end
    let(:parties) { FactoryBot.create_list(:party, 3) }

    let!(:send_message_with_parties) do
      stub_request(:post, send_message_api)
        .with(body: {
          chat_id:,
          text: JSON.pretty_generate(parties.as_json)
        }.to_json)
        .to_return(status: 200)
    end

    it 'sends message with parties' do
      execute

      expect(send_message_with_parties).to have_been_requested
    end
  end
end
