defmodule Zendex.HttpClient.InMemory do

  def get!("http://test.zendesk.com/api/v2/tickets.json", [{"Authorization", authentication}]) do
    "ticket"
  end
end
