defmodule Zendex.TicketTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  alias Zendex.Connection

  @cassette_dir "test/fixtures/vcr_cassettes/tickets"

  setup_all do
    ExVCR.Config.cassette_library_dir(@cassette_dir)
    HTTPoison.start
  end

  setup do
    {:ok, conn: Connection.setup("https://test.zendesk.com", "User1", "Pass")}
  end

  test "getting tickets", %{conn: conn} do
    expected = %{"count" => 4,
                 "next_page" => nil,
                 "previous_page" => nil,
                 "tickets" => [%{"id" => 1},
                               %{"id" => 2},
                               %{"id" => 3},
                               %{"id" => 4}]}
    use_cassette "list_tickets" do
      actual = Zendex.Ticket.list(conn)

      assert expected == actual
    end
  end

  test "listing tickets with pagination", %{conn: conn} do
    expected = [%{"count" => 4,
                  "next_page" => "https://test.zendesk.com/api/v2/tickets.json?page=2",
                  "previous_page" => nil,
                  "tickets" => [%{"id" => 1}, %{"id" => 2}]},
                %{"count" => 4,
                  "next_page" => nil,
                  "previous_page" => "https://test.zendesk.com/api/v2/tickets.json?page=1",
                  "tickets" => [%{"id" => 3}, %{"id" => 4}]}]
    use_cassette "list_tickets_pagination" do
      actual = Zendex.Ticket.list(conn, pagination: :auto)

      assert expected == actual
    end
  end

  test "listing only first page", %{conn: conn} do
    expected = %{"count" => 4,
                 "next_page" => "https://test.zendesk.com/api/v2/tickets.json?page=2",
                 "previous_page" => nil,
                 "tickets" => [%{"id" => 1}, %{"id" => 2}]}
    use_cassette "list_tickets_pagination" do
      actual = Zendex.Ticket.list(conn, pagination: :none)

      assert expected == actual
    end

  end

  test "creating a ticket", %{conn: conn} do
    expected = %{"ticket" => %{"id" => 1234,
                               "description" => "My printer is on fire!"}}
    use_cassette "create_ticket" do
      ticket = %{"ticket" => %{"description" => "My printer is on fire!"}}
      actual = Zendex.Ticket.create(conn, ticket)

      assert expected == actual
    end
  end
end
