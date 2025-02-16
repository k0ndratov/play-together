# frozen_string_literal: true

RSpec.describe Telegram::Commands::CreateParty do
  include_context 'with send message stub'

  shared_examples 'sends message' do |expected_message|
    let!(:send_message_stub_call) { send_message_stub(chat_id, expected_message) }

    it "sends message: #{expected_message}" do
      execute
      expect(send_message_stub_call).to have_been_requested
    end
  end

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, params).execute }

    let(:params) { 'GoGo Play together' }
    let(:chat_id) { 1 }

    context 'when party name is blank' do
      let(:params) { '' }

      it_behaves_like 'sends message', 'Please provide a name for the party'
    end

    context 'when user does not exist' do
      it_behaves_like 'sends message', "Couldn't create a party"
    end

    context 'when user exists' do
      let(:chat_id) { FactoryBot.create(:user)[:telegram_id] }

      expected_message = 'Party created: GoGo Play together, ID: 1'

      before do
        send_message_stub(chat_id, expected_message)
      end

      it_behaves_like 'sends message', expected_message

      it "creates a user's party membership" do
        execute

        user = User.kept.find_by(telegram_id: chat_id)
        party = Party.kept.find_by(name: params)
        party_membership = PartyMembership.kept.find_by(user: user, party: party)

        expect(user.parties).to include(party)
        expect(party.users).to include(user)
        expect(party_membership).to be_present
      end
    end
  end
end
