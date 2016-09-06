defmodule Zendex.Ticket do

  @spec list(Zendex.Connection.t) :: String.t
  def list(connection) do
    tickets_url = "/api/v2/tickets.json"

    HTTPoison.get!(connection.base_url <> tickets_url, [{"Authorization", 
       "Basic #{connection.authentication}"}])
  end

end
