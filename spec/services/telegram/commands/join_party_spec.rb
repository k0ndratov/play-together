# frozen_string_literal: true

RSpec.describe Telegram::Commands::JoinParty do
  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, params).execute }

    include_context 'with send message stub'

    let(:chat_id) { FactoryBot.attributes_for(:user)[:telegram_id] }

    context 'when party id is invalid' do
      let!(:send_error_message_stub) do
        send_message_stub(chat_id, 'Invalid ID')
      end

      [
        { desc: 'id is nil', params: nil },
        { desc: 'id is blank', params: '' },
        { desc: 'id is not integer', params: 'asdf' },
        { desc: 'id is not positive', params: '-12' },
        { desc: 'id is 0', params: '0' }
      ].each do |scenario|
        context "when #{scenario[:desc]}" do
          let(:params) { scenario[:params] }

          it 'returns an error message' do
            execute
            expect(send_error_message_stub).to have_been_requested.once
          end
        end
      end
    end

    context 'when the party does not exist' do
      let!(:send_error_message_stub) do
        send_message_stub(chat_id, 'Could not find party with this id')
      end
      let(:params) { '10' }

      it 'returns an error message' do
        execute
        expect(send_error_message_stub).to have_been_requested.once
      end
    end

    context 'when the user does not exist' do
      let!(:send_error_message_stub) do
        send_message_stub(chat_id, 'Failed to join the party')
      end
      let(:party) { FactoryBot.create(:party) }
      let(:params) { party.id }

      it 'returns an error message' do
        execute
        expect(send_error_message_stub).to have_been_requested.once
      end
    end

    context 'when the user already in the party' do
      let(:chat_id) { user.telegram_id }
      let!(:send_error_message_stub) do
        send_message_stub(chat_id, 'You are already in this party')
      end
      let(:user) { FactoryBot.create(:user, :with_parties) }
      let(:params) { user.parties.first.id }

      it 'returns an error message' do
        execute
        expect(send_error_message_stub).to have_been_requested.once
      end
    end

    context 'when the user successfully join the party' do
      let(:chat_id) { user.telegram_id }
      let!(:send_success_message_stub) do
        send_message_stub(chat_id, "You have joined the party '#{party.name}'")
      end
      let(:user) { FactoryBot.create(:user) }
      let(:party) { FactoryBot.create(:party) }
      let(:params) { party.id }

      it 'returns an success message' do
        execute
        expect(send_success_message_stub).to have_been_requested.once
      end
    end
  end
end
