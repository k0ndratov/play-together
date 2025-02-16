# frozen_string_literal: true

RSpec.describe SteamSpyService do
  describe '.random_game_name' do
    context 'when request to Steamspy API is successful' do
      let(:asserted_game_name) { 'Satisfactory' }

      before do
        stub_request(:get, 'https://steamspy.com/api.php?request=top100in2weeks')
          .to_return(
            status: 200,
            body: { '1234' => { 'name' => asserted_game_name } }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )
      end

      it 'returns a tuple with random game name' do
        success, name = described_class.random_game_name

        expect(success).to be true
        expect(name).to eq asserted_game_name
      end
    end

    context 'when request to Steamspy API fails' do
      before do
        stub_request(:get, 'https://steamspy.com/api.php?request=top100in2weeks')
          .to_return(
            status: 500,
            body: 'Internal Server Error'
          )
      end

      it 'returns a tuple with error message' do
        success, reason = described_class.random_game_name

        expect(success).to be false
        expect(reason).to eq 'SteamSpy failed to load popular games'
      end
    end
  end
end
