defmodule Zendex.User do
  @moduledoc """
  Interact with Zendesk user.
  """

  alias Zendex.CommonHelpers

  @url "/api/v2/users"
  @http_client Application.get_env(:zendex, :http_client)

  @doc """
  List all users.
  """
  @spec list(Zendex.Connection.t) :: map
  def list(connection) do
    "#{connection.base_url}#{@url}.json"
    |> @http_client.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Show a specific user, given their id.

  ## Examples

      iex> conn = Zendex.Connection.setup("http://test.zendesk.com", "ZendeskUser", "Password1")
      %{authentication: "WmVuZGVza1VzZXI6UGFzc3dvcmQx", base_url: "http://test.zendesk.com"}
      iex> Zendex.User.show(conn, 295204)
      %{"user" => %{"ticket_restriction" => nil,
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

  """
  @spec show(Zendex.Connection.t, integer) :: map
  def show(connection, id) do
    "#{connection.base_url}#{@url}/#{id}.json"
    |> @http_client.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Show many user, given their ids.
  """
  @spec show_many(Zendex.Connection.t, [integer]) :: map
  def show_many(connection, ids) do
    ids = Enum.join(ids, ",")

    "#{connection.base_url}#{@url}/show_many.json?ids=#{ids}"
    |> @http_client.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @spec related_information(Zendex.Connection.t, integer) :: map
  def related_information(connection, id) do
    "#{connection.base_url}#{@url}/#{id}/related.json"
    |> @http_client.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Create a new user.
  """
  @spec create(Zendex.Connection.t, map) :: map
  def create(connection, user) do
    "#{connection.base_url}#{@url}.json"
    |> @http_client.post!(Poison.encode!(user),
                          CommonHelpers.get_headers(connection.authentication,
                                                    %{content_type: :json}))
    |> CommonHelpers.decode_response
  end

  @doc """
  Delete a user.

  ## Examples

      iex> conn = Zendex.Connection.setup("http://test.zendesk.com", "ZendeskUser", "Password1")
      %{authentication: "WmVuZGVza1VzZXI6UGFzc3dvcmQx", base_url: "http://test.zendesk.com"}
      iex> Zendex.User.delete(conn, 49043)
      %{"user" => %{"ticket_restriction" => nil,
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


  """
  @spec show(Zendex.Connection.t, integer) :: map
  def delete(connection, id) do
    "#{connection.base_url}#{@url}/#{id}.json"
    |> @http_client.delete!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

end
