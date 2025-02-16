# frozen_string_literal: true

RSpec.describe Telegram::Commands::CreateParty do
  include_context 'with send message stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, params).execute }

    let(:params) { 'GoGo Play together' }
    let(:chat_id) { 1 }

    context 'when party name is blank' do
      let(:params) { '' }
      let!(:send_error_message) do
        send_message_stub(chat_id, 'Please provide a name for the party')
      end

      it 'returns error message' do
        execute

        expect(send_error_message).to have_been_requested
      end
    end

    context 'when user does not exist' do
      let!(:send_error_message) do
        send_message_stub(chat_id, "Couldn't create a party")
      end

      it 'returns error message' do
        execute

        expect(send_error_message).to have_been_requested
      end
    end

    context 'when user exists' do
      let(:params) { 'Big party!' }
      let(:chat_id) { FactoryBot.create(:user)[:telegram_id] }
      let!(:send_success_message) do
        send_message_stub(chat_id, 'Party created: Big party!, ID: 1')
      end

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
