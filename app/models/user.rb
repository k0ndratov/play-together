# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model

  validates :telegram_id, presence: true, uniqueness: true
  validates :username, uniqueness: true

  has_many :party_memberships, dependent: :destroy
  has_many :parties, through: :party_memberships

  class << self
    def from_telegram(user_info)
      user = find_or_initialize_by(telegram_id: user_info[:id])
      user.update!(
        username: user_info[:username],
        first_name: user_info[:first_name],
        last_name: user_info[:last_name]
      )

      user
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
