defmodule Zendex.ConnectionTest do
  use ExUnit.Case, async: true

  test "setup encodes username and password correctly" do
    expected = %{authentication: "WHhYQXdlc29tZVVzZXJuYW1lWHhYOnBhc3N3b3JkMTIz",
                 base_url: ""}
    actual = Zendex.Connection.setup("", "XxXAwesomeUsernameXxX", "password123")

    assert expected == actual
  end

end
