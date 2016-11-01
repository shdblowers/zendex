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
    expected = %{"user" => %{"ticket_restriction" => nil,
                             "chat_only" => false,
                             "shared_phone_number" => nil,
                             "notes" => "",
                             "phone" => nil,
                             "organization_id" => 11129520411,
                             "last_login_at" => "2016-10-28T21:08:23Z",
                             "moderator" => true,
                             "shared" => false,
                             "id" => 295204,
                             "role" => "admin",
                             "external_id" => nil,
                             "shared_agent" => false,
                             "photo" => nil,
                             "verified" => true,
                             "active" => true,
                             "locale_id" => 1,
                             "suspended" => false,
                             "created_at" => "2015-05-28T09:12:45Z",
                             "name" => "Nikolao Aikema",
                             "restricted_agent" => false,
                             "locale" => "en-US",
                             "details" => "",
                             "alias" => nil,
                             "url" => "https://test.zendesk.com/api/v2/users/295204.json",
                             "custom_role_id" => nil,
                             "email" => "nikolao.aikema@test.com",
                             "signature" => nil,
                             "two_factor_auth_enabled" => nil,
                             "time_zone" => "London",
                             "only_private_comments" => false,
                             "user_fields" => %{"customer_complaint" => nil},
                             "tags" => [],
                             "updated_at" => "2016-10-28T21:08:23Z"}}
    actual = Zendex.User.show(context[:conn], 295204)

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
