# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[8.0]
  def change
    create_table :users do |t|
      t.integer :telegram_id
      t.string :username
      t.string :first_name
      t.string :last_name

      t.timestamps
    end
    add_index :users, :telegram_id, unique: true
    add_index :users, :username, unique: true
  end
end
