defmodule Zendex.Search do
  @moduledoc """
  Allows use of the Zendex search API functionality.
  """

  alias Zendex.CommonHelpers

  @url "/api/v2/search.json?query="
  @http_client Application.get_env(:zendex, :http_client)

  @spec query(Zendex.Connection.t, map, String.t, String.t) :: map
  def query(connection, query, sort_by \\ "", sort_order \\ "desc") do

    search_string = create_search_string(query)
    sort_string = create_sort_string(sort_by, sort_order)

    connection.base_url
    |> Kernel.<>(@url)
    |> Kernel.<>(search_string)
    |> Kernel.<>(sort_string)
    |> @http_client.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
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
