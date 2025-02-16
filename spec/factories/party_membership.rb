# frozen_string_literal: true

FactoryBot.define do
  factory :party_membership do
    user
    party
  end
end
