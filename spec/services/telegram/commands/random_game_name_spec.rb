# frozen_string_literal: true

RSpec.describe Telegram::Commands::RandomGameName do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id, nil).execute
    end

    let(:chat_id) { 1 }
    let(:command_text) { '/random_game_name' }
    let(:top_games_api) { 'https://steamspy.com/api.php?request=top100in2weeks' }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end
    let!(:send_game_name_stub) do
      stub_request(:post, send_message_api)
        .with(body: {
          chat_id: chat_id,
          text: 'Satisfactory'
        }.to_json)
        .to_return(status: 200)
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
