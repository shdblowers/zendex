defmodule Zendex.User do
  @moduledoc """
  Interact with Zendesk user.
  """

  @url "/api/v2/users"

  @doc """
  List all users.
  """
  @spec list(Zendex.Connection.t, Keyword.t) :: map | [map]
  def list(connection, opts \\ []) do
    "#{@url}.json"
    |> Zendex.get!(connection, [], opts)
  end

  @doc """
  Show a specific user, given their id.
  """
  @spec show(Zendex.Connection.t, integer) :: map
  def show(connection, id) do
    "#{@url}/#{id}.json"
    |> Zendex.get!(connection)
  end

  @doc """
  Show many user, given their ids.
  """
  @spec show_many(Zendex.Connection.t, [integer]) :: no_return
  def show_many(connection, ids) do
    ids = Enum.join(ids, ",")
    "#{@url}/show_many.json?ids=#{ids}"
    |> Zendex.get!(connection)
  end

  @doc """
  Show information relating to the user, example: number of assigned tickets.
  """
  @spec related_information(Zendex.Connection.t, integer) :: no_return
  def related_information(connection, id) do
    "#{@url}/#{id}/related.json"
    |> Zendex.get!(connection)
  end

  @doc """
  Create a new user.
  """
  @spec create(Zendex.Connection.t, map) :: any
  def create(connection, user) do
    "#{@url}.json"
    |> Zendex.post!(connection, Poison.encode!(user))
  end

  @doc """
  Delete a user.
  """
  @spec delete(Zendex.Connection.t, integer) :: {integer, map} | map
  def delete(connection, id) do
    "#{@url}/#{id}.json"
    |> Zendex.delete!(connection)
  end

end
