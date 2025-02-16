# frozen_string_literal: true

class AddDiscardedAtToUsersPartiesAndPartyMemberships < ActiveRecord::Migration[8.0]
  def change
    add_column :users, :discarded_at, :datetime
    add_index :users, :discarded_at

    add_column :parties, :discarded_at, :datetime
    add_index :parties, :discarded_at

    add_column :party_memberships, :discarded_at, :datetime
    add_index :party_memberships, :discarded_at
  end
end
