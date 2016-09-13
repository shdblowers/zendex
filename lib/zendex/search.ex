defmodule Zendex.Search do
  @moduledoc  """
  Allows use of the Zendex search API functionality.
  """

  @url "/api/v2/search.json?query="
  @http_client Application.get_env(:zendex, :http_client)

  @spec query(Zendex.Connection.t, map, String.t, String.t)
    :: HTTPoison.Response.t
  def query(connection, query, sort_by \\ "", sort_order \\ "desc") do
    search_string = create_search_string(query)
    sort_string = create_sort_string(sort_by, sort_order)

    full_uri = connection.base_url <> @url <> search_string <> sort_string

    @http_client.get!(full_uri,
                      [{"Authorization", "Basic #{connection.authentication}"}])
  end

  defp create_search_string(query) do
    query
    |> Enum.map(&convert(&1))
    |> Enum.join(" ")
    |> URI.encode_www_form
  end

  defp convert({:type, type}), do: "type:#{type}"
  defp convert({:requester, requester}), do: "requester:#{requester}"

  defp create_sort_string("", _sort_order), do: ""
  defp create_sort_string(sort_by, sort_order) do
    "&sort_by=#{sort_by}&sort_order=#{sort_order}"
  end

end
