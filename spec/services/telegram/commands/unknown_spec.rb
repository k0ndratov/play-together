# frozen_string_literal: true

RSpec.describe Telegram::Commands::Unknown do
  include_context 'with send message stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, nil).execute }

    let(:chat_id) { 1 }
    let!(:send_unknown_message_stub) do
      send_message_stub(chat_id, 'Unknown command.')
    end

    it 'sends an unknown message' do
      execute
      expect(send_unknown_message_stub).to have_been_requested.once
    end
  end
end
