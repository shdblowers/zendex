defmodule Zendex.UserTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  doctest Zendex.User

  @cassette_dir "test/fixtures/vcr_cassettes/users"

  alias Zendex.Connection

  setup_all do
    ExVCR.Config.cassette_library_dir(@cassette_dir)
    HTTPoison.start
  end

  setup do
    {:ok, conn: Connection.setup("https://test.zendesk.com", "User1", "pass")}
  end

  test "list users", %{conn: conn} do
    expected = %{"count" => 4,
                 "next_page" => nil,
                 "previous_page" => nil,
                 "users" => [%{"id" => 1},
                             %{"id" => 2},
                             %{"id" => 3},
                             %{"id" => 4}]}
    use_cassette "list_users" do
      actual = Zendex.User.list(conn)

      assert expected == actual
    end
  end

  test "showing a user", %{conn: conn} do
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

    use_cassette "show_user" do
      actual = Zendex.User.show(conn, 295204)
      assert expected == actual
    end
  end

  test "showing many users", %{conn: conn} do
    expected = %{"users" => [%{"id" => 6, "name" => "Kiki Segal"},
                             %{"id" => 67, "name" => "Sarpedon Baumgartner"}]}
    use_cassette "show_many_users" do
      actual = Zendex.User.show_many(conn, [6,67])

      assert expected == actual
    end
  end

  test "getting related info on a user", %{conn: conn} do
    expected = %{"user_related" => %{"assigned_tickets" => 12,
                                     "ccd_tickets" => 5,
                                     "entry_subscriptions" => 1,
                                     "forum_subscriptions" => 3,
                                     "organization_subscriptions" => 1,
                                     "requested_tickets" => 7,
                                     "subscriptions" => 6,
                                     "topic_comments" => 116,
                                     "topics" => 5,
                                     "votes" => 2001}}
    use_cassette "related_information" do
      actual = Zendex.User.related_information(conn, 649267)

      assert expected == actual
    end
  end

  test "creating a user", %{conn: conn} do
    expected = %{"user" => %{"id" => 1234, "name" => "Roger", "email" => "roger@dodger.com"}}
    use_cassette "create_user" do
      actual = Zendex.User.create(conn, %{user: %{name: "Roger", email: "roger@dodger.com"}})

      assert expected == actual
    end
  end

  test "deleting a user", %{conn: conn} do
    expected = %{"user" => %{"ticket_restriction" => nil,
                             "chat_only" => false,
                             "shared_phone_number" => nil,
                             "notes" => "",
                             "phone" => nil,
                             "organization_id" => 149043,
                             "last_login_at" => "2016-10-28T21:08:23Z",
                             "moderator" => true,
                             "shared" => false,
                             "id" => 49043,
                             "role" => "admin",
                             "external_id" => nil,
                             "shared_agent" => false,
                             "photo" => nil,
                             "verified" => true,
                             "active" => false,
                             "locale_id" => 1,
                             "suspended" => false,
                             "created_at" => "2015-05-28T09:12:45Z",
                             "name" => "Rian Hawkins",
                             "restricted_agent" => false,
                             "locale" => "en-US",
                             "details" => "",
                             "alias" => nil,
                             "url" => "https://test.zendesk.com/api/v2/users/49043.json",
                             "custom_role_id" => nil,
                             "email" => "rian.hawkins@test.com",
                             "signature" => nil,
                             "two_factor_auth_enabled" => nil,
                             "time_zone" => "London",
                             "only_private_comments" => false,
                             "user_fields" => %{"customer_complaint" => nil},
                             "tags" => [],
                             "updated_at" => "2016-10-28T21:08:23Z"}}

    use_cassette "delete_user" do
      actual = Zendex.User.delete(conn, 49043)

      assert expected == actual
    end
  end
end
