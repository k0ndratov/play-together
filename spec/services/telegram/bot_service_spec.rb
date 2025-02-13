# frozen_string_literal: true

RSpec.describe Telegram::BotService do
  let(:send_message_api) do
    'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
  end
  let(:top_games_api) { 'https://steamspy.com/api.php?request=top100in2weeks' }

  let(:chat_id) { 1 }

  let(:params) do
    {
      message: {
        from: {
          id: chat_id,
          username: 'k0ndratov',
          first_name: 'Андрей',
          last_name: 'Кондратов'
        },
        chat: { id: chat_id },
        text:
      },
      controller: 'telegram_bot',
      action: 'webhook'
    }
  end

  describe '.process_command' do
    subject(:process_command) do
      described_class.process_command(params)
    end

    context 'when text is an unknown command' do
      let(:text) { '/unknown_command' }
      let!(:send_unknown_command_stub) do
        stub_request(:post, send_message_api)
          .with(body: {
            chat_id:,
            text: 'Unknown command.'
          }.to_json)
          .to_return(status: 200)
      end

      it 'sends unknown command message' do
        process_command
        expect(send_unknown_command_stub).to have_been_requested.once
      end
    end

    context 'when text is a command' do
      context 'with /random_game_name' do
        let(:text) { '/random_game_name' }
        let!(:send_game_name_stub) do
          stub_request(:post, send_message_api)
            .with(body: {
              chat_id:,
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

        it 'sends game name message' do
          process_command
          expect(send_game_name_stub).to have_been_requested.once
        end
      end

      context 'with /user_info' do
        let(:text) { '/user_info' }
        let!(:send_user_info_stub) do
          stub_request(:post, send_message_api)
            .with(body: {
              chat_id:,
              text: 'Ваш уникальный ID: 1. Ваш никнейм: k0ndratov.'
            }.to_json)
            .to_return(status: 200)
        end

        it 'sends user info message' do
          process_command
          expect(send_user_info_stub).to have_been_requested.once
        end
      end
    end

    context 'when text is not a command' do
      let(:text) { 'Just a text' }
      let!(:send_suggestion_stub) do
        stub_request(:post, send_message_api)
          .with(body: {
            chat_id:,
            text: 'Did you just send the text? I suggest you try "/random_game_name".'
          }.to_json)
          .to_return(status: 200)
      end

      it 'sends suggestion message' do
        process_command
        expect(send_suggestion_stub).to have_been_requested.once
      end
    end
  end

  describe '.command?' do
    it 'returns true for commands' do
      expect(described_class.command?('/command')).to be true
    end

    it 'returns false for non-commands' do
      expect(described_class.command?('not command')).to be false
    end
  end
end
