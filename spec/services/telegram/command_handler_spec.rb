# frozen_string_literal: true

RSpec.describe Telegram::CommandHandler do
  let(:chat_id) { 1 }
  let(:command_text) { '/random_game_name' }

  describe '.execute' do
    subject(:execute) do
      described_class.execute(chat_id, command_text)
    end

    context 'when text is a command' do
      context 'without params' do
        let(:command_instance) { instance_spy(Telegram::Commands::RandomGameName) }

        it 'handles command without params' do
          allow(Telegram::Commands::RandomGameName).to receive(:new)
            .with(chat_id, nil).and_return(command_instance)

          execute

          expect(Telegram::Commands::RandomGameName).to have_received(:new)
            .with(chat_id, nil)
          expect(command_instance).to have_received(:execute)
        end
      end

      context 'with params' do
        let(:command_text) { '/create_party Awesome Group' }
        let(:command_instance) { instance_spy(Telegram::Commands::CreateParty) }

        it 'handles command with params' do
          allow(Telegram::Commands::CreateParty).to receive(:new)
            .with(chat_id, 'Awesome Group').and_return(command_instance)

          execute

          expect(Telegram::Commands::CreateParty).to have_received(:new)
            .with(chat_id, 'Awesome Group')
          expect(command_instance).to have_received(:execute)
        end
      end
    end

    context 'when text is an unknown command' do
      let(:command_text) { '/unknown_command' }
      let(:command_instance) { instance_spy(Telegram::Commands::Unknown) }

      it 'handles unknown command' do
        allow(Telegram::Commands::Unknown).to receive(:new).with(chat_id, nil).and_return(command_instance)

        execute

        expect(Telegram::Commands::Unknown).to have_received(:new)
          .with(chat_id, nil)
        expect(command_instance).to have_received(:execute)
      end
    end

    #   context 'when text is a command' do
    #     context 'with /random_game_name' do
    #       let(:text) { '/random_game_name' }
    #       let!(:send_game_name_stub) do
    #         stub_request(:post, send_message_api)
    #           .with(body: {
    #             chat_id:,
    #             text: 'Satisfactory'
    #           }.to_json)
    #           .to_return(status: 200)
    #       end

    #       before do
    #         stub_request(:get, top_games_api)
    #           .to_return(
    #             status: 200,
    #             body: { '1' => { 'name' => 'Satisfactory' } }.to_json,
    #             headers: { 'Content-Type' => 'application/json' }
    #           )
    #       end

    #       it 'sends game name message' do
    #         process_command
    #         expect(send_game_name_stub).to have_been_requested.once
    #       end
    #     end

    #     context 'with /user_info' do
    #       let(:text) { '/user_info' }
    #       let!(:send_user_info_stub) do
    #         stub_request(:post, send_message_api)
    #           .with(body: {
    #             chat_id:,
    #             text: 'Ваш уникальный ID: 1. Ваш никнейм: k0ndratov.'
    #           }.to_json)
    #           .to_return(status: 200)
    #       end

    #       it 'sends user info message' do
    #         process_command
    #         expect(send_user_info_stub).to have_been_requested.once
    #       end
    #     end
    #   end

    #   context 'when text is not a command' do
    #     let(:text) { 'Just a text' }
    #     let!(:send_suggestion_stub) do
    #       stub_request(:post, send_message_api)
    #         .with(body: {
    #           chat_id:,
    #           text: 'Did you just send the text? I suggest you try "/random_game_name".'
    #         }.to_json)
    #         .to_return(status: 200)
    #     end

    #     it 'sends suggestion message' do
    #       process_command
    #       expect(send_suggestion_stub).to have_been_requested.once
    #     end
    #   end
    # end

    # describe '.command?' do
    #   it 'returns true for commands' do
    #     expect(described_class.command?('/command')).to be true
    #   end

    #   it 'returns false for non-commands' do
    #     expect(described_class.command?('not command')).to be false
    #   end
  end
end
