# frozen_string_literal: true

RSpec.describe Telegram::Commands::CreateParty do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id, params).execute
    end

    let(:params) { 'GoGo Play together' }
    let(:chat_id) { 1 }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end

    context 'when party name is black' do
      let(:params) { '' }
      let!(:send_error_message) do
        stub_request(:post, send_message_api)
          .with(body: {
            chat_id:,
            text: 'Please provide a name for the party'
          }.to_json)
          .to_return(status: 200)
      end

      it 'returns error message' do
        execute

        expect(send_error_message).to have_been_requested
      end
    end

    context 'when user does not exists' do
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

    context 'when user exists' do
      let(:params) { 'Big party!' }
      let!(:send_success_message) do
        stub_request(:post, send_message_api)
          .with(body: {
            chat_id:,
            text: 'Party created: Big party!, ID: 1'
          }.to_json)
          .to_return(status: 200)
      end
      let(:chat_id) { FactoryBot.create(:user)[:telegram_id] }

      it 'returns success message' do
        execute

        expect(send_success_message).to have_been_requested
      end

      it "creates a user's party membership" do
        execute

        user = User.kept.find_by(telegram_id: chat_id)
        party = Party.kept.find_by(name: 'Big party!')
        party_membership = PartyMembership.kept.find_by(user: user, party: party)

        expect(user.parties).to include(party)
        expect(party.users).to include(user)
        expect(party_membership).to be_present
      end
    end
  end
end
