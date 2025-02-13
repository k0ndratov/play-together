# frozen_string_literal: true

module Telegram
  # Service for creating a new user.
  class CreateUser
    def self.call(user_info)
      user = ::User.find_or_initialize_by(telegram_id: user_info[:id])
      user.assign_attributes(
        username: user_info[:username],
        first_name: user_info[:first_name],
        last_name: user_info[:last_name]
      )
      user.save!

      user
    end
  end
end
