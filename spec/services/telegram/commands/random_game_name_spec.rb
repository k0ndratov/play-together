# frozen_string_literal: true

RSpec.describe Telegram::Commands::RandomGameName do
  include_context 'with send message stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id, nil).execute }

    let(:chat_id) { 1 }
    let(:top_games_api) { 'https://steamspy.com/api.php?request=top100in2weeks' }
    let!(:send_game_name_stub) do
      send_message_stub(chat_id, 'Satisfactory')
    end

    before do
      stub_request(:get, top_games_api)
        .to_return(
          status: 200,
          body: { '1' => { 'name' => 'Satisfactory' } }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
    end

    it 'sends a random game name' do
      execute
      expect(send_game_name_stub).to have_been_requested.once
    end
  end
end
