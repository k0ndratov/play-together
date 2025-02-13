# frozen_string_literal: true

module Telegram
  module Commands
    class CreateParty < Telegram::Commands::Base
      def execute
        name = params
        return send_message('Please provide a name for the party') if name.blank?

        party = Party.new(name:)
        user = ::User.find_by(telegram_id: chat_id)
        return send_message("Couldn't create a party") unless user

        party.users << user
        party.save!
        send_message("Party created: #{party.name}, ID: #{party.id}")
      end
    end
  end
end
