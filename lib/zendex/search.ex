defmodule Zendex.Search do
  @moduledoc """
  Allows use of the Zendex search API functionality.
  """

  @url "/api/v2/search.json?query="

  @doc """
  Search Zendesk.
  """
  @spec query(Zendex.Connection.t, map, String.t, String.t) :: no_return
  def query(connection, query, sort_by \\ "", sort_order \\ "desc") do

    search_string = create_search_string(query)
    sort_string = create_sort_string(sort_by, sort_order)

    "#{@url}#{search_string}#{sort_string}"
    |> Zendex.get!(connection)
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
