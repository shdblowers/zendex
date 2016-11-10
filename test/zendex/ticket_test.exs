defmodule Zendex.TicketTest do
  use ExUnit.Case, async: true

  alias Zendex.Connection

  setup do
    {:ok, conn: Connection.setup("http://test.zendesk.com", "User", "Passw")}
  end

  test "getting tickets", %{conn: conn} do
    assert "ticket" == Zendex.Ticket.list(conn)
  end

  test "creating a ticket", %{conn: conn} do
    assert "Ticket created successfully!" ==
      Zendex.Ticket.create(conn, %{"ticket": %{}})
  end
end
