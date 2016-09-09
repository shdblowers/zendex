defmodule Zendex.Ticket do
  @moduledoc """
  Allows interaction with the Zendesk Ticket API, to so things such as creating
  and listing tickets.
  """

  @url "/api/v2/tickets.json"

  @http_client Application.get_env(:zendex, :http_client)

  @spec list(Zendex.Connection.t) :: String.t
  def list(connection) do
    @http_client.get!(connection.base_url <> @url, [{"Authorization",
       "Basic #{connection.authentication}"}])
  end

  def create(connection, ticket) do
    @http_client.post!(connection.base_url <> @url,
      Poison.encode!(ticket),
      [{"Authorization", "Basic #{connection.authentication}"},
       {"Content-Type", "application/json"}])
  end

end
