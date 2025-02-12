# frozen_string_literal: true

RSpec.describe Telegram::Commands::JoinParty do
  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, params).execute }

    let(:chat_id) { FactoryBot.attributes_for(:user)[:telegram_id] }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end

    context 'when party id is invalid' do
      let!(:send_error_message_stub) do
        stub_request(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: 'Invalid ID' }.to_json)
          .to_return(status: 200)
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
        stub_request(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: 'Could not find party with this id' }.to_json)
          .to_return(status: 200)
      end
      let(:params) { '10' }

      it 'returns an error message' do
        execute
        expect(send_error_message_stub).to have_been_requested.once
      end
    end

    context 'when the user does not exist' do
      let!(:send_error_message_stub) do
        stub_request(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: 'Failed to join the party' }.to_json)
          .to_return(status: 200)
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
        stub_request(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: 'You are already in this party' }.to_json)
          .to_return(status: 200)
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
        stub_request(:post, send_message_api)
          .with(body: { chat_id: chat_id, text: "You have joined the party '#{party.name}'" }.to_json)
          .to_return(status: 200)
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
