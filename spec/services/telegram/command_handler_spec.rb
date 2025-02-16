# frozen_string_literal: true

RSpec.describe Telegram::CommandHandler do
  describe '.execute' do
    subject(:execute) { described_class.execute(chat_id, command_text) }

    let(:chat_id) { 1 }

    context 'when text is a command' do
      context 'without params' do
        let(:command_text) { '/random_game_name' }
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
  end
end
