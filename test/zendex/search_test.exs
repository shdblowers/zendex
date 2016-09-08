defmodule Zendex.SearchTest do
  use ExUnit.Case

  test "doing a search" do
   conn = Zendex.Connection.set_up("http://test.zendesk.com", "User", "Pass")
   assert ["Jimbob Ticket 1", "Jimbob Ticket 2"]
    == Zendex.Search.query(conn, %{type: "ticket", requester: "Jimbob"})
  end

end
