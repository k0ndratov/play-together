# frozen_string_literal: true

RSpec.describe TelegramBotController, type: :controller do
  def params_with_text(text)
    { message: { text: text, chat: { id: chat_id } } }
  end

  describe '#webhook' do
    let(:chat_id) { '1234' }

    context 'when message is blank' do
      it 'returns 200 OK' do
        post :webhook, params: { message: nil }

        expect(response).to have_http_status :ok
      end
    end

    context 'when text is not a command' do
      it 'returns 200 OK' do
        post :webhook, params: params_with_text('not a command')

        expect(response).to have_http_status :ok
      end
    end

    context 'when command is unknown' do
      before do
        allow(TelegramBotService).to receive(:send_message)
      end

      it 'send unknown command message' do
        post :webhook, params: params_with_text('/unknown_command')

        expect(TelegramBotService).to have_received(:send_message).with(chat_id, 'Unknown command.')
        expect(response).to have_http_status :ok
      end
    end

    context 'when command is /random_game_name' do
      let(:game_name) { 'Satisfactory' }

      before do
        allow(SteamSpyService).to receive(:random_game_name).and_return(game_name)
        allow(TelegramBotService).to receive(:send_message)
      end

      it 'send random game name message' do
        post :webhook, params: params_with_text('/random_game_name')

        expect(TelegramBotService).to have_received(:send_message).with(chat_id, game_name)
        expect(response).to have_http_status :ok
      end
    end
  end
end
