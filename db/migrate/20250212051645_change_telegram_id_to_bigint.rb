# frozen_string_literal: true

class ChangeTelegramIdToBigint < ActiveRecord::Migration[8.0]
  def up
    change_column :users, :telegram_id, :bigint
  end

  def down
    change_column :users, :telegram_id, :integer
  end
end
