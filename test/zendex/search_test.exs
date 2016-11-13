defmodule Zendex.SearchTest do
  use ExUnit.Case, async: false
  use ExVCR.Mock, adapter: ExVCR.Adapter.Hackney

  @cassette_dir "test/fixtures/vcr_cassettes/search"

  alias Zendex.Connection

  setup_all do
    ExVCR.Config.cassette_library_dir(@cassette_dir)
    HTTPoison.start
  end

  setup do
    {:ok, conn: Connection.setup("https://test.zendesk.com", "User1", "Pass")}
  end

  test "doing a search", %{conn: conn} do
    expected = %{"count" => 2,
                 "facets" => nil,
                 "next_page" => nil,
                 "previous_page" => nil,
                 "results" => [
                    %{"id" => 1, "description" => "Jimbob Ticket 1"},
                    %{"id" => 2, "description" => "Jimbob Ticket 2"}]}

    use_cassette "search_tickets" do
      actual = Zendex.Search.query(conn, %{type: "ticket", requester: "Jimbob"})

      assert actual == expected
    end
  end

  test "doing a search with sorting", %{conn: conn} do
    expected = %{"count" => 2,
                 "facets" => nil,
                 "next_page" => nil,
                 "previous_page" => nil,
                 "results" => [
                    %{"id" => 1, "description" => "Reginald Ticket 1"},
                    %{"id" => 2, "description" => "Reginald Ticket 2"}]}

    use_cassette "search_tickets_sorting" do
      actual = Zendex.Search.query(conn,
                                   %{type: "ticket", requester: "Reginald"},
                                   "created_at",
                                   "desc")

      assert actual == expected
    end
  end

end
