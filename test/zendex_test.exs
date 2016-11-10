defmodule ZendexTest do
  use ExUnit.Case
  import Zendex

  doctest Zendex

  setup_all do
    :meck.new(Poison, [:no_link])

    on_exit fn ->
      :meck.unload Poison
    end
  end

  test "authorization_header using user and password" do
    auth = %{authentication: "dXNlcjpwYXNzd29yZA=="}
    expected = [{"Authorization", "Basic dXNlcjpwYXNzd29yZA=="}]
    assert authorization_header(auth, []) == expected
  end

  test "process response on a 200 response" do
    assert process_response(%HTTPoison.Response{status_code: 200,
                                                headers: %{},
                                                body: "json" }) == "json"
    assert :meck.validate(Poison)
  end

  test "process response on a non-200 response" do
    assert process_response(%HTTPoison.Response{status_code: 404,
                                                headers: %{},
                                                body: "json" }) == {404, "json"}
    assert :meck.validate(Poison)
  end

  test "process_response_body with an empty body" do
    assert process_response_body("") == nil
  end

  test "process_response_body with content" do
    :meck.expect(Poison, :decode!, 1, :decoded_json)
    assert process_response_body("json") == :decoded_json
  end

  test "process response on a non-200 response and empty body" do
    assert process_response(%HTTPoison.Response{status_code: 404,
                                                headers: %{},
                                                body: nil }) == {404, nil}
  end
end
