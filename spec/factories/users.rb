# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Smith' }
    username { 'j0hnsmith' }
    telegram_id { 1 }
    sequence(:id) { |n| n }
  end
end
