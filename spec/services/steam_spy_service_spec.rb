# frozen_string_literal: true

RSpec.describe SteamSpyService do
  include_context 'with top games stub'

  describe '.random_game_name' do
    context 'when request to Steamspy API is successful' do
      let(:asserted_game_name) { 'Satisfactory' }

      before do
        top_games_stub
      end

      it 'returns a tuple with random game name' do
        success, name = described_class.random_game_name

        expect(success).to be true
        expect(name).to eq asserted_game_name
      end
    end

    context 'when request to Steamspy API fails' do
      before do
        top_games_stub('Internal Server Error', 500)
      end

      it 'returns a tuple with error message' do
        success, reason = described_class.random_game_name

        expect(success).to be false
        expect(reason).to eq 'SteamSpy failed to load popular games'
      end
    end
  end
end
