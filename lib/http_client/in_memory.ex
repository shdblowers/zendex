defmodule Zendex.HttpClient.InMemory do
  @moduledoc """
  Allows testing of the Zendex project by mocking out calls to an actual Zendesk
  API.
  """

  @base_url "http://test.zendesk.com"

  def get!(@base_url <> "/api/v2/users.json",
           [{"Authorization", _authentication}]) do
    fake_response("users")
  end

  def get!("#{@base_url}/api/v2/users/295204.json",
           [{"Authorization", _authentication}]) do
    fake_response(%{"user" => %{"ticket_restriction" => nil,
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
                                "updated_at" => "2016-10-28T21:08:23Z"}})
  end

  def get!("#{@base_url}/api/v2/users/show_many.json?ids=6,67",
           [{"Authorization", _authentication}]) do
    fake_response(%{users: [%{id: 6, name: "Kiki Segal"},
                            %{id: 67, name: "Sarpedon Baumgartner"}]})
  end

  def get!("#{@base_url}/api/v2/users/649267/related.json",
           [{"Authorization", _authentication}]) do
    fake_response(%{"user_related" => %{"assigned_tickets" => 12,
                                        "ccd_tickets" => 5,
                                        "entry_subscriptions" => 1,
                                        "forum_subscriptions" => 3,
                                        "organization_subscriptions" => 1,
                                        "requested_tickets" => 7,
                                        "subscriptions" => 6,
                                        "topic_comments" => 116,
                                        "topics" => 5,
                                        "votes" => 2001}})
  end

  def post!(@base_url <> "/api/v2/users.json",
            "{\"user\":{\"name\":\"Roger\",\"email\":\"roger@dodger.com\"}}",
            [{"Authorization", _authentication}, {"Content-Type", "application/json"}]) do
    fake_response(%{user: %{id: 1234, name: "Roger", email: "roger@dodger.com"}})
  end

  def delete!("#{@base_url}/api/v2/users/49043.json",
           [{"Authorization", _authentication}]) do
    fake_response(%{"user" => %{"ticket_restriction" => nil,
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
                                "updated_at" => "2016-10-28T21:08:23Z"}})
  end

  defp fake_response(body), do: %{body: Poison.encode!(body)}
end
