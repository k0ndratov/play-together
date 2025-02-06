class SteamSpyServiceTest < ActiveSupport::TestCase
  test "shoud return random game name" do
    asserted_game_name = "Satisfactory"
    stub_request(:get, "https://steamspy.com/api.php?request=top100in2weeks")
      .to_return(
        status: 200,
        body: { "1234" => { "name" => asserted_game_name } }.to_json,
        headers: { "Content-Type" => "application/json" },
      )

    random_game_name = SteamSpyService.random_game_name

    assert_equal asserted_game_name, random_game_name
  end

  test "shoud return nil if the request to steamspy api failed" do
    stub_request(:get, "https://steamspy.com/api.php?request=top100in2weeks")
      .to_return(
        status: 500,
        body: "Internal Server Error",
      )

    random_game_name = SteamSpyService.random_game_name

    assert_nil random_game_name
  end
end
