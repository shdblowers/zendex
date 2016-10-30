defmodule Zendex.TicketTest do
  use ExUnit.Case, async: true

  setup do
    [conn: Zendex.Connection.set_up("http://test.zendesk.com", "User", "Passw")]
  end

  test "getting tickets", context do
   assert "ticket" == Zendex.Ticket.list(context[:conn])
  end

  test "creating a ticket", context do
    assert "Ticket created successfully!" ==
      Zendex.Ticket.create(context[:conn], %{"ticket": %{}})
  end
end
