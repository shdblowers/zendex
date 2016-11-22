defmodule Zendex.TicketTest do
  use ExUnit.Case, async: false

  setup do
    %{conn: Zendex.Connection.setup("http://test.zendesk.com", "User", "Passw")}
  end

  setup_all do
    :meck.new(HTTPoison)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "getting tickets", %{conn: conn} do
    expected = "ticket"

    stub = fn("http://test.zendesk.com/api/v2/tickets.json", _headers) ->
      %HTTPoison.Response{body: Poison.encode!(expected)}
    end
    :meck.expect(HTTPoison, :get!, stub)

    assert expected == Zendex.Ticket.list(conn)
  end

  test "creating a ticket", %{conn: conn} do
    expected = "Ticket created successfully!"

    stub = fn("http://test.zendesk.com/api/v2/tickets.json",
              "{\"ticket\":{\"title\":\"HELP!\"}}",
              _headers) ->
      %HTTPoison.Response{body: Poison.encode!(expected)}
    end
    :meck.expect(HTTPoison, :post!, stub)

    assert expected ==
      Zendex.Ticket.create(conn, %{"ticket": %{"title": "HELP!"}})
  end
end
