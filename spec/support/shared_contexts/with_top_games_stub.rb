# frozen_string_literal: true

TOP_GAMES_API = 'https://steamspy.com/api.php?request=top100in2weeks'
RESPONSE = { '1234' => { 'name' => 'Satisfactory' } }.freeze

RSpec.shared_context 'with top games stub' do
  def top_games_stub(response = RESPONSE, status = 200)
    stub_request(:get, TOP_GAMES_API)
      .to_return(
        status:,
        body: response.to_json,
        headers: { 'Content-Type' => 'application/json' }
      )
  end
end
