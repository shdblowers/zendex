defmodule Zendex.Search do

  @url "/search.json"

  @http_client Application.get_env(:zendex, :http_client)

  def query(query) do
    query
    |> extract
    |> Enum.join(" ")
    |> URI.encode
  end

  defp extract(query) do
    Enum.map(query, &convert(&1))
  end

  defp convert({:type, type}), do: "type:#{type}"
  defp convert({:requester, requester}), do: "requester:#{requester}"


end
