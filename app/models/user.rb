# frozen_string_literal: true

class User < ApplicationRecord
  include Discard::Model

  validates :telegram_id, presence: true, uniqueness: true

  has_many :party_memberships, dependent: :destroy
  has_many :parties, through: :party_memberships
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
