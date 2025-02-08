# frozen_string_literal: true

RSpec.describe SteamSpyService do
  describe '.random_game_name' do
    context 'when request to Steamspy API is successfull' do
      it 'returns a random game name' do
        asserted_game_name = 'Satisfactory'
        stub_request(:get, 'https://steamspy.com/api.php?request=top100in2weeks')
          .to_return(
            status: 200,
            body: { '1234' => { 'name' => asserted_game_name } }.to_json,
            headers: { 'Content-Type' => 'application/json' }
          )

        random_game_name = described_class.random_game_name

        expect(random_game_name).to eq(asserted_game_name)
      end
    end

    context 'when request to Steamspy API is failured' do
      it 'returns nil' do
        stub_request(:get, 'https://steamspy.com/api.php?request=top100in2weeks')
          .to_return(
            status: 500,
            body: 'Internal Server Error'
          )

        random_game_name = described_class.random_game_name

        expect(random_game_name).to be_nil
      end
    end
  end
end
