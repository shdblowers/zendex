defmodule Zendex.TicketTest do
  use ExUnit.Case

  test "getting tickets" do
   conn = Zendex.Connection.set_up("http://test.zendesk.com", "User", "Pass")
   assert "ticket" == Zendex.Ticket.list(conn)
  end
end
