# frozen_string_literal: true

RSpec.describe Telegram::Commands::AllParties do
  include_context 'with send message stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, nil).execute }

    let(:chat_id) { 1 }
    let(:parties) { FactoryBot.create_list(:party, 3) }

    let!(:send_message_with_parties) do
      send_message_stub(chat_id, JSON.pretty_generate(parties.as_json))
    end

    it 'sends message with parties' do
      execute

      expect(send_message_with_parties).to have_been_requested
    end
  end
end
