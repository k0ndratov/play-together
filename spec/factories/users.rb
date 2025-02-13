# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    first_name { 'John' }
    last_name { 'Smith' }
    username { 'j0hnsmith' }
    sequence(:telegram_id, 15) { |n| n }
  end
end
