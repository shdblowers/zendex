defmodule Zendex.TicketTest do
  use ExUnit.Case, async: false

  setup do
    %{conn: Zendex.Connection.setup("http://test.zendesk.com",
                                    "User",
                                    "Password123!")}
  end

  setup_all do
    :meck.new(HTTPoison)
    on_exit fn -> :meck.unload end
    :ok
  end

  test "getting tickets", %{conn: conn} do
    stub = fn("http://test.zendesk.com/api/v2/tickets.json",
              [{"Authorization", "Basic VXNlcjpQYXNzd29yZDEyMyE="}]) ->
      %HTTPoison.Response{body: Poison.encode!("ticket")}
    end
    :meck.expect(HTTPoison, :get!, stub)

    assert "ticket" == Zendex.Ticket.list(conn)
  end

  test "creating a ticket", %{conn: conn} do
    stub = fn("http://test.zendesk.com/api/v2/tickets.json",
              "{\"ticket\":{\"title\":\"HELP!\"}}",
              [{"Authorization", "Basic VXNlcjpQYXNzd29yZDEyMyE="},
               {"Content-Type", "application/json"}]) ->
      %HTTPoison.Response{body: Poison.encode!("Ticket created successfully!")}
    end
    :meck.expect(HTTPoison, :post!, stub)

    assert "Ticket created successfully!" ==
      Zendex.Ticket.create(conn, %{"ticket": %{"title": "HELP!"}})
  end
end
