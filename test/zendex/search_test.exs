defmodule Zendex.SearchTest do
  use ExUnit.Case, async: true

  setup do
    [conn: Zendex.Connection.setup("http://test.zendesk.com", "User", "Passw")]
  end

  test "doing a search", context do
    expected = ["Jimbob Ticket 1", "Jimbob Ticket 2"]

    actual = Zendex.Search.query(context[:conn],
                                 %{type: "ticket", requester: "Jimbob"})

    assert actual == expected
  end

  test "doing a search with sorting", context do
    expected = ["Reginald Ticket 1", "Reginald Ticket 2"]

    actual = Zendex.Search.query(context[:conn],
                                 %{type: "ticket", requester: "Reginald"},
                                 "created_at",
                                 "desc")

    assert actual == expected
  end

end
