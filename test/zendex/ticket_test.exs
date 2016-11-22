defmodule Zendex.TicketTest do
  use ExUnit.Case, async: true

  setup do
    [conn: Zendex.Connection.setup("http://test.zendesk.com", "User", "Passw")]
  end

  setup_all do
    :meck.new(HTTPoison)

    on_exit fn ->
      :meck.unload
    end

    :ok
  end

  test "getting tickets", context do
    :meck.expect(HTTPoison,
                 :get!,
                 fn("http://test.zendesk.com/api/v2/tickets.json", [{"Authorization", "Basic VXNlcjpQYXNzdw=="}]) ->
                   %HTTPoison.Response{body: Poison.encode!("ticket")}
                 end)

    assert "ticket" == Zendex.Ticket.list(context[:conn])
  end

  test "creating a ticket", context do
    :meck.expect(HTTPoison,
                 :post!,
                 fn(_, _, _) ->
                   %HTTPoison.Response{body: Poison.encode!("Ticket created successfully!")}
                 end)

    assert "Ticket created successfully!" ==
      Zendex.Ticket.create(context[:conn], %{"ticket": %{}})
  end
end
