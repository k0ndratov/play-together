# frozen_string_literal: true

class Party < ApplicationRecord
  has_many :party_memberships, dependent: :destroy
  has_many :users, through: :party_memberships
end

# == Schema Information
#
# Table name: parties
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
