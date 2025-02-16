# frozen_string_literal: true

RSpec.describe Telegram::Commands::UserInfo do
  include_context 'with send message stub'

  describe '#execute' do
    subject(:execute) { described_class.new(chat_id).execute }

    let(:chat_id) { FactoryBot.attributes_for(:user)[:telegram_id] }
    let(:user) { FactoryBot.create(:user, telegram_id: chat_id) }
    let!(:send_user_info_stub) do
      send_message_stub(chat_id, "Ваш уникальный ID: #{user.id}. Ваш никнейм: #{user.username}.")
    end

    it 'sends info about user' do
      execute
      expect(send_user_info_stub).to have_been_requested.once
    end
  end
end
