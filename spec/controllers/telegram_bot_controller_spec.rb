# frozen_string_literal: true

RSpec.describe TelegramBotController, type: :controller do
  describe '#webhook' do
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end
    let(:top_games_api) { 'https://steamspy.com/api.php?request=top100in2weeks' }
    let(:params) do
      { message: { chat: { id: '123' }, text: '/random_game_name' }, 'controller' => 'telegram_bot',
        'action' => 'webhook' }
    end

    context 'when posted webhook' do
      it 'returns 200 OK' do
        post :webhook

        expect(response).to have_http_status :ok
      end
    end

    context 'when the message is presented' do
      before do
        allow(TelegramBotService).to receive(:process_command)
      end

      it 'the command handler was called' do
        post(:webhook, params:)

        expect(TelegramBotService).to have_received(:process_command).with(ActionController::Parameters.new(params))
        expect(response).to have_http_status :ok
      end
    end

    context 'when the message is /random_game_name' do
      let(:expected_body) { { chat_id: '123', text: 'Satisfactory' }.to_json }

      before do
        stub_request(:post, send_message_api).to_return(status: 200)
        stub_request(:get, top_games_api).to_return(
          status: 200,
          body: { '1' => { 'name' => 'Satisfactory' } }.to_json,
          headers: { 'Content-Type' => 'application/json' }
        )
      end

      it 'sends game name message to telegram bot' do
        post(:webhook, params:)

        expect(a_request(:post, send_message_api).with(body: expected_body)).to have_been_made.once
      end
    end
  end
end
