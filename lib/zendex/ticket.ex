defmodule Zendex.Ticket do
  @moduledoc """
  Allows interaction with the Zendesk Ticket API, to so things such as creating
  and listing tickets.
  """

  alias Zendex.CommonHelpers

  @url "/api/v2/tickets.json"
  @http_client Application.get_env(:zendex, :http_client)

  @spec list(Zendex.Connection.t) :: map
  def list(connection) do
    connection.base_url
    |> Kernel.<>(@url)
    |> @http_client.get!(headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @spec create(Zendex.Connection.t, map) :: map
  def create(connection, ticket) do
    connection.base_url
    |> Kernel.<>(@url)
    |> @http_client.post!(Poison.encode!(ticket),
                          headers(connection.authentication) ++
                            [{"Content-Type", "application/json"}])
    |> CommonHelpers.decode_response
  end

  defp headers(authentication) do
    [{"Authorization", "Basic #{authentication}"}]
  end
end
