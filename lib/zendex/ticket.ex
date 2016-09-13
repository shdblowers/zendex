defmodule Zendex.Ticket do
  @moduledoc """
  Allows interaction with the Zendesk Ticket API, to so things such as creating
  and listing tickets.
  """

  @url "/api/v2/tickets.json"

  @http_client Application.get_env(:zendex, :http_client)

  @spec list(Zendex.Connection.t) :: map
  def list(connection) do
    connection.base_url
    |> Kernel.<>(@url)
    |> @http_client.get!(headers(connection.authentication))
    |> decode_response
  end

  @spec create(Zendex.Connection.t, map) :: map
  def create(connection, ticket) do
    response = @http_client.post!(connection.base_url <> @url,
                                  Poison.encode!(ticket),
                                  headers(connection.authentication) ++
                                    [{"Content-Type", "application/json"}])

    decode_response(response)
  end

  defp decode_response(%{body: body}), do: Poison.decode!(body)

  defp headers(authentication) do
    [{"Authorization", "Basic #{authentication}"}]
  end
end
