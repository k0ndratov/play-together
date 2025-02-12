# frozen_string_literal: true

RSpec.describe Telegram::Commands::UserInfo do
  describe '#execute' do
    subject(:execute) do
      described_class.new(chat_id).execute
    end

    let(:chat_id) { FactoryBot.attributes_for(:user)[:telegram_id] }
    let(:send_message_api) do
      'https://api.telegram.org/botfake39:tokenDO9yV0OOIpYCFT82FBiz_l2-riZZqs/sendMessage'
    end
    let!(:send_user_info_stub) do
      stub_request(:post, send_message_api)
        .with(body: {
          chat_id: chat_id,
          text: "Ваш уникальный ID: #{user.id}. Ваш никнейм: #{user.username}."
        }.to_json)
        .to_return(status: 200)
    end
    let(:user) { FactoryBot.create(:user, telegram_id: chat_id) }

    it 'sends info about user' do
      execute

      expect(send_user_info_stub).to have_been_requested.once
    end
  end
end
