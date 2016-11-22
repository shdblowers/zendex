defmodule Zendex.User do
  @moduledoc """
  Interact with Zendesk user.
  """

  alias Zendex.CommonHelpers

  @url "/api/v2/users"

  @doc """
  List all users.
  """
  @spec list(Zendex.Connection.t) :: map
  def list(connection) do
    "#{connection.base_url}#{@url}.json"
    |> HTTPoison.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Show a specific user, given their id.
  """
  @spec show(Zendex.Connection.t, integer) :: map
  def show(connection, id) do
    "#{connection.base_url}#{@url}/#{id}.json"
    |> HTTPoison.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Show many user, given their ids.
  """
  @spec show_many(Zendex.Connection.t, [integer]) :: map
  def show_many(connection, ids) do
    ids = Enum.join(ids, ",")

    "#{connection.base_url}#{@url}/show_many.json?ids=#{ids}"
    |> HTTPoison.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Show information relating to the user, example: number of assigned tickets.
  """
  @spec related_information(Zendex.Connection.t, integer) :: map
  def related_information(connection, id) do
    "#{connection.base_url}#{@url}/#{id}/related.json"
    |> HTTPoison.get!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

  @doc """
  Create a new user.
  """
  @spec create(Zendex.Connection.t, map) :: map
  def create(connection, user) do
    "#{connection.base_url}#{@url}.json"
    |> HTTPoison.post!(Poison.encode!(user),
                          CommonHelpers.get_headers(connection.authentication,
                                                    %{content_type: :json}))
    |> CommonHelpers.decode_response
  end

  @doc """
  Delete a user.
  """
  @spec show(Zendex.Connection.t, integer) :: map
  def delete(connection, id) do
    "#{connection.base_url}#{@url}/#{id}.json"
    |> HTTPoison.delete!(CommonHelpers.get_headers(connection.authentication))
    |> CommonHelpers.decode_response
  end

end
