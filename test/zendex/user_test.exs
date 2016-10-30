defmodule Zendex.UserTest do
  use ExUnit.Case, async: true

  setup do
    [conn: Zendex.Connection.setup("http://test.zendesk.com", "User1", "pass")]
  end

  test "list users", context do
    expected = "users"
    actual = Zendex.User.list(context[:conn])

    assert expected == actual
  end

  test "showing a user", context do
    expected = %{"user" => %{"id" => 87, "name" => "Quim Stroud"}}
    actual = Zendex.User.show(context[:conn], 87)

    assert expected == actual
  end

  test "showing many users", context do
    expected = %{"users" => [%{"id" => 6, "name" => "Kiki Segal"},
                             %{"id" => 67, "name" => "Sarpedon Baumgartner"}]}
    actual = Zendex.User.show_many(context[:conn], [6,67])

    assert expected == actual
  end

  test "creating a user", context do
    expected = %{"user" => %{"id" => 1234, "name" => "Roger", "email" => "roger@dodger.com"}}
    actual = Zendex.User.create(context[:conn], %{user: %{name: "Roger", email: "roger@dodger.com"}})

    assert expected == actual
  end
end
