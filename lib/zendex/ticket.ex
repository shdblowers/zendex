defmodule Zendex.Ticket do

  def list(connection) do
    tickets_url = "/api/v2/tickets.json"

    HTTPoison.get!(connection.base_url <> tickets_url, [{"Authorization", "Basic #{Base.encode64("#{connection.username}:#{connection.password}")}"}])
  end

end
