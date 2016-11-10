defmodule Zendex.SearchTest do
  use ExUnit.Case, async: true

  alias Zendex.Connection

  setup do
    {:ok, conn: Connection.setup("http://test.zendesk.com", "User", "Passw")}
  end

  test "doing a search", %{conn: conn} do
    expected = ["Jimbob Ticket 1", "Jimbob Ticket 2"]

    actual = Zendex.Search.query(conn, %{type: "ticket", requester: "Jimbob"})

    assert actual == expected
  end

  test "doing a search with sorting", %{conn: conn} do
    expected = ["Reginald Ticket 1", "Reginald Ticket 2"]

    actual = Zendex.Search.query(conn,
                                 %{type: "ticket", requester: "Reginald"},
                                 "created_at",
                                 "desc")

    assert actual == expected
  end

end
