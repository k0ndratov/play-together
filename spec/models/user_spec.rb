# frozen_string_literal: true

RSpec.describe User, type: :model do
  describe '.from_telegram' do
    let(:user_data) do
      {
        id: 1,
        username: 'k0ndratov',
        first_name: 'Андрей',
        last_name: 'Кондратов'
      }
    end
    let(:updated_user_data) do
      {
        id: 1,
        username: 'ruby0nRailsMaster',
        first_name: 'Andrei',
        last_name: 'Kondratov'
      }
    end

    context 'when user exists' do
      let!(:existed_user) { FactoryBot.create(:user) }

      it 'updates user data' do
        expect { described_class.from_telegram(updated_user_data) }
          .not_to change(described_class, :count)

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
        expect { described_class.from_telegram(user_data) }
          .to change(described_class, :count).by(1)

        expect(described_class.find(1)).to have_attributes(
          username: 'k0ndratov',
          first_name: 'Андрей',
          last_name: 'Кондратов'
        )
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id          :integer          not null, primary key
#  first_name  :string
#  last_name   :string
#  username    :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  telegram_id :bigint
#
# Indexes
#
#  index_users_on_telegram_id  (telegram_id) UNIQUE
#  index_users_on_username     (username) UNIQUE
#
