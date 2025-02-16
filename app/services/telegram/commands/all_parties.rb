# frozen_string_literal: true

module Telegram
  module Commands
    class AllParties < Telegram::Commands::Base
      command '/all_parties'

      def execute
        send_message(JSON.pretty_generate(Party.all.as_json))
      end
    end
  end
end
