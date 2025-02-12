# frozen_string_literal: true

class CreatePartyMemberships < ActiveRecord::Migration[8.0]
  def change
    create_table :party_memberships do |t|
      t.references :user, null: false, foreign_key: true
      t.references :party, null: false, foreign_key: true

      t.timestamps
    end
  end
end
