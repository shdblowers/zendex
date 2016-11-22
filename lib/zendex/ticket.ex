defmodule Zendex.Ticket do
  @moduledoc """
  Allows interaction with the Zendesk Ticket API, to so things such as creating
  and listing tickets.
  """

  @url "/api/v2/tickets.json"

  @doc """
  List all tickets.
  """
  @spec list(Zendex.Connection.t, Keyword.t) :: [any] | {integer, any}
  def list(connection, opts \\ []) do
    "#{@url}"
    |> Zendex.get!(connection, [], opts)
  end

  @doc """
  Create a new ticket.
  """
  @spec create(Zendex.Connection.t, map) :: any
  def create(connection, ticket) do
    "#{@url}"
    |> Zendex.post!(connection, Poison.encode!(ticket))
  end
end
