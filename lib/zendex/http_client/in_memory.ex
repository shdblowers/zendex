defmodule Zendex.HttpClient.InMemory do
  @moduledoc """
  Allows testing of the Zendex project by mocking out calls to an actual Zendesk
  API.
  """

  def get!("http://test.zendesk.com/api/v2/tickets.json", [{"Authorization", authentication}]) do
    "ticket"
  end

  def get!("http://test.zendesk.com/api/v2/search.json?query=requester%3AJimbob+type%3Aticket", [{"Authorization", authentication}]) do
    ["Jimbob Ticket 1", "Jimbob Ticket 2"]
  end
end
