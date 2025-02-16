# frozen_string_literal: true

RSpec.describe Telegram::Commands::RandomGameName do
  include_context 'with send message stub'
  include_context 'with top games stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, nil).execute }

    let(:chat_id) { 1 }
    let!(:send_game_name_stub) do
      send_message_stub(chat_id, 'Satisfactory')
    end

    before do
      top_games_stub
    end

    it 'sends a random game name' do
      execute
      expect(send_game_name_stub).to have_been_requested.once
    end
  end
end
