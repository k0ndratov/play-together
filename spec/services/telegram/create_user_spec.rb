# frozen_string_literal: true

RSpec.describe Telegram::CreateUser do
  describe '.call' do
    let(:telegram_id) { FactoryBot.attributes_for(:user)[:telegram_id] }
    let(:user_data) do
      {
        id: telegram_id,
        username: 'k0ndratov',
        first_name: 'Андрей',
        last_name: 'Кондратов'
      }
    end
    let(:updated_user_data) do
      {
        id: telegram_id,
        username: 'ruby0nRailsMaster',
        first_name: 'Andrei',
        last_name: 'Kondratov'
      }
    end

    context 'when user exists' do
      let!(:existed_user) { FactoryBot.create(:user, telegram_id:) }

      it 'updates existing user' do
        expect { described_class.call(updated_user_data) }
          .not_to change(User, :count)
        existed_user.reload
        expect(existed_user).to have_attributes(
          username: 'ruby0nRailsMaster',
          first_name: 'Andrei',
          last_name: 'Kondratov'
        )
      end
    end

    context 'when user does not exist' do
      it 'creates a new user' do
        expect { described_class.call(user_data) }
          .to change(User, :count).by(1)

        expect(User.find_by(telegram_id: telegram_id)).to have_attributes(
          username: 'k0ndratov',
          first_name: 'Андрей',
          last_name: 'Кондратов'
        )
      end
    end
  end
end
