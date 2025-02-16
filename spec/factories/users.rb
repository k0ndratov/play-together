# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    username { Faker::Internet.username }
    sequence(:telegram_id, 15) { |n| n }

    transient do
      parties_count { 3 }
    end

    trait :with_parties do
      after(:create) do |user, evaluator|
        create_list(
          :party_membership,
          evaluator.parties_count,
          user:,
          party: create(:party)
        )
      end
    end
  end
end

# == Schema Information
#
# Table name: users
#
#  id           :integer          not null, primary key
#  discarded_at :datetime
#  first_name   :string
#  last_name    :string
#  username     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  telegram_id  :bigint
#
# Indexes
#
#  index_users_on_discarded_at  (discarded_at)
#  index_users_on_telegram_id   (telegram_id) UNIQUE
#  index_users_on_username      (username) UNIQUE
#
