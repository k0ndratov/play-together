# frozen_string_literal: true

class PartyMembership < ApplicationRecord
  belongs_to :user
  belongs_to :party
end

# == Schema Information
#
# Table name: party_memberships
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  party_id   :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_party_memberships_on_party_id  (party_id)
#  index_party_memberships_on_user_id   (user_id)
#
# Foreign Keys
#
#  party_id  (party_id => parties.id)
#  user_id   (user_id => users.id)
#
