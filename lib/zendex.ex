defmodule Zendex do
  @moduledoc """
  HTTPoison Zendesk Client
  """
  use HTTPoison.Base
  alias Zendex.Connection
  alias HTTPoison.Response

  @user_agent [{"user-agent", "zendex"}]

  @type response :: {integer, any} | map

  @spec process_response_body(binary) :: term
  def process_response_body(""), do: nil
  def process_response_body(body), do: Poison.decode!(body)

  @spec process_response(HTTPoison.Response.t) :: response
  def process_response(%Response{status_code: 200, body: body}) do
    body
  end
  def process_response(%Response{status_code: status_code, body: body}) do
    {status_code, body}
  end

  @spec delete!(binary, Zendex.Connection.t, binary) :: any | {integer, any}
  def delete!(path, connection, body \\ "") do
    _request(:delete, url(connection, path), connection.authentication, body)
  end

  @spec post(binary, Zendex.Connection.t, binary) :: any | {integer, any}
  def post(path, connection, body \\ "") do
    _request(:post, url(connection, path), connection.authentication, body)
  end

  @spec post!(binary, Zendex.Connection.t, binary) :: any | {integer, any}
  def post!(path, connection, body \\ "") do
    {201, resp} = post(path, connection, body)
    resp
  end

  def patch(path, connection, body \\ "") do
    _request(:patch, url(connection, path), connection.authentication, body)
  end

  def patch!(path, connection, body \\ "") do
    {_, resp} = patch(path, connection, body)
    resp
  end

  @doc """
  Underlying utility retrieval function

  The options passed affect both the return value and, ultimately, the number
  of requests made to Zendesk.

  Options:
  * `pagination` - can be `:none`, or `:auto`. Defaults to `:none`.
  """
  @spec get!(binary, Zendex.Connection.t, Keyword.t, Keyword.t) :: term
  def get!(path, connection, params \\ [], options \\ []) do
    url =
      connection
      |> url(path)
      |> add_params_to_url(params)

    {auth, _} = Map.split(connection, [:authentication])

    case pagination(options) do
      nil -> request_stream(:get, url, auth, "", :one_page)
      :none -> request_stream(:get, url, auth, "", :one_page)
      :auto ->
        :get
        |> request_stream(url, auth)
        |> realize_if_needed
    end
  end

  def _request(method, url, auth, body \\ "") do
    json_request(method, url, body, authorization_header(auth, @user_agent))
  end

  def json_request(method, url, body \\ "", headers \\ [], options \\ []) do
    raw_request(method, url, Poison.encode!(body), headers, options)
  end

  defp pagination(options) do
    options
      |> Keyword.get(:pagination)
      |> case do
        nil -> Application.get_env(:zendex, :pagination, nil)
        x -> x end
  end

  def raw_request(method, url, body \\ "", headers \\ [], options \\ []) do
    method
    |> request!(url, body, headers, options)
    |> process_response
  end

  def request_stream(method, url, auth, body \\ "", override \\ nil) do
    method
    |> request_with_pagination(url, auth, Poison.encode!(body))
    |> stream_if_needed(override)
  end
  defp stream_if_needed(result = {status_code, _}, _)
    when is_number(status_code), do: result
  defp stream_if_needed({body, nil, _}, _), do: body
  defp stream_if_needed({body, _, _}, :one_page), do: body
  defp stream_if_needed(initial_results, _) do
    Stream.resource(
      fn -> initial_results end,
      &process_stream/1,
      fn _ -> nil end)
  end

  defp realize_if_needed(x)
    when is_tuple(x) or is_binary(x) or is_list(x) or is_map(x), do: x
  defp realize_if_needed(stream), do: Enum.to_list(stream)

  defp process_stream({[], nil, _}), do: {:halt, nil}
  defp process_stream({[], next, auth}) do
    :get
    |> request_with_pagination(next, auth, "")
    |> process_stream
  end
  defp process_stream({items, next, auth}) when is_list(items) do
    {items, {[], next, auth}}
  end
  defp process_stream({item, next, auth}) do
    {[item], {[], next, auth}}
  end

  @spec request_with_pagination(atom, binary, Connection.auth, binary) ::
    {binary, binary, Zendex.Connection.auth}
  def request_with_pagination(method, url, auth, body \\ "") do
    resp = request!(method,
                    url,
                    Poison.encode!(body),
                    authorization_header(auth, @user_agent),
                    [])
    case process_response(resp) do
      x when is_tuple(x) -> x
      _ -> pagination_tuple(resp, auth)
    end
  end

  @spec pagination_tuple(HTTPoison.Response.t, Connection.auth) ::
    {binary, binary, Connection.auth}
  defp pagination_tuple(%Response{body: body} = resp, auth) do
    {process_response(resp), next_link(body), auth}
  end

  defp next_link(%{"next_page" => next}), do: next
  defp next_link(_), do: nil

  defp url(_client = %{base_url: base_url}, path = "/" <> _) do
    base_url <> path
  end

  @doc """
  Take an existing URI and add addition parameters, merging as necessary

  ## Examples
      iex> add_params_to_url("http://example.com/wat", [])
      "http://example.com/wat"
      iex> add_params_to_url("http://example.com/wat", [q: 1])
      "http://example.com/wat?q=1"
      iex> add_params_to_url("http://example.com/wat", [q: 1, t: 2])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat", %{q: 1, t: 2})
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&t=2", [])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1", [t: 2])
      "http://example.com/wat?q=1&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1", [q: 3, t: 2])
      "http://example.com/wat?q=3&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&s=4", [q: 3, t: 2])
      "http://example.com/wat?q=3&s=4&t=2"
      iex> add_params_to_url("http://example.com/wat?q=1&s=4", %{q: 3, t: 2})
      "http://example.com/wat?q=3&s=4&t=2"

  """
  @spec add_params_to_url(binary, list) :: binary
  def add_params_to_url(url, params) do
    url
    |> URI.parse
    |> merge_uri_params(params)
    |> to_string
  end

  @spec merge_uri_params(URI.t, list) :: URI.t
  defp merge_uri_params(uri, []), do: uri
  defp merge_uri_params(%URI{query: nil} = uri, params)
      when is_list(params) or is_map(params) do
    uri
    |> Map.put(:query, URI.encode_query(params))
  end
  defp merge_uri_params(%URI{} = uri, params)
      when is_list(params) or is_map(params) do
    uri
    |> Map.update!(:query, fn q ->
      q
      |> URI.decode_query
      |> Map.merge(param_list_to_map_with_string_keys(params))
      |> URI.encode_query
    end)
  end

  @spec param_list_to_map_with_string_keys(list) :: map
  defp param_list_to_map_with_string_keys(list)
      when is_list(list) or is_map(list) do
    for {key, value} <- list, into: Map.new do
      {"#{key}", value}
    end
  end

  @spec authorization_header(Connection.auth, list) :: list
  def authorization_header(%{authentication: authentication}, headers) do
    headers ++ [{"Authorization", "Basic #{authentication}"}]
  end
  def authorization_header(_, headers), do: headers

end
