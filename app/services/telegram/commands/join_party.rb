# frozen_string_literal: true

module Telegram
  module Commands
    class JoinParty < Telegram::Commands::Base
      command '/join_party'

      def execute
        success, result = valid_params?
        return send_message(result) unless success

        user, party = result

        party_membership = ::PartyMembership.new(party:, user:)
        return send_message('Failed to join the group') unless party_membership.save

        send_message("You have joined the party '#{party.name}'")
      end

      def valid_params?
        id = params.to_i
        return [false, 'Invalid ID'] unless id.positive?

        party = ::Party.kept.find_by(id:)
        return [false, 'Could not find party with this id'] unless party

        user = ::User.kept.find_by(telegram_id: chat_id)
        return [false, 'Failed to join the party'] unless user

        existed_party_membership = ::PartyMembership.find_by(party:, user:)
        return [false, 'You are already in this party'] if existed_party_membership

        [true, [user, party]]
      end
    end
  end
end
