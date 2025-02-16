# frozen_string_literal: true

FactoryBot.define do
  factory :party do
    name { "#{Faker::Music::RockBand.name} Party" }
  end
end

# == Schema Information
#
# Table name: parties
#
#  id           :integer          not null, primary key
#  discarded_at :datetime
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
# Indexes
#
#  index_parties_on_discarded_at  (discarded_at)
#
