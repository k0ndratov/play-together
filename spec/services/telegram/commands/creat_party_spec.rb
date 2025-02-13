RSpec.describe Telegram::Commands::CreateParty do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id, params).execute
    end

    let(:params) { 'GoGo Play together' }
    let(:chat_id) { 15 }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end

    context 'user does not exists' do
      let!(:send_error_message) do
        stub_request(:post, send_message_api)
          .with(body: {
            chat_id:,
            text: "Couldn't create a party"
          }.to_json)
          .to_return(status: 200)
      end

      it 'returns error message' do
        execute

        expect(send_error_message).to have_been_requested
      end
    end
  end
end
