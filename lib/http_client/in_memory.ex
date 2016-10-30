defmodule Zendex.HttpClient.InMemory do
  @moduledoc """
  Allows testing of the Zendex project by mocking out calls to an actual Zendesk
  API.
  """

  @base_url "http://test.zendesk.com"

  def get!(@base_url <> "/api/v2/tickets.json",
           [{"Authorization", _authentication}]) do
    fake_response("ticket")
  end

  def get!(@base_url <> "/api/v2/search.json?query=requester%3AJimbob+type%3Aticket",
           [{"Authorization", _authentication}]) do
    fake_response(["Jimbob Ticket 1", "Jimbob Ticket 2"])
  end

  def get!(@base_url <> "/api/v2/search.json?query=requester%3AReginald+type%3Aticket&sort_by=created_at&sort_order=desc",
           [{"Authorization", _authentication}]) do
    fake_response(["Reginald Ticket 1", "Reginald Ticket 2"])
  end

  def get!(@base_url <> "/api/v2/users.json",
           [{"Authorization", _authentication}]) do
    fake_response("users")
  end

  def get!("#{@base_url}/api/v2/users/87.json",
           [{"Authorization", _authentication}]) do
    fake_response(%{"user": %{"id": 87, "name": "Quim Stroud"}})
  end

  def post!(@base_url <> "/api/v2/tickets.json",
            "{\"ticket\":{}}",
            [{"Authorization", _authentication}, {"Content-Type", "application/json"}]) do
    fake_response("Ticket created successfully!")
  end

  def post!(@base_url <> "/api/v2/users.json",
            "{\"user\":{\"name\":\"Roger\",\"email\":\"roger@dodger.com\"}}",
            [{"Authorization", _authentication}, {"Content-Type", "application/json"}]) do
    fake_response(%{user: %{id: 1234, name: "Roger", email: "roger@dodger.com"}})
  end

  defp fake_response(body), do: %{body: Poison.encode!(body)}
end
