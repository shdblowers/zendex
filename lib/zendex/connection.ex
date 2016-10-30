defmodule Zendex.Connection do
  @moduledoc """
  Establishes connection details with Zendex by the user providing a base url,
  username and password.
  """

  @typedoc "The connection paramters"
  @type t :: %{base_url: String.t, authentication: binary}

  @doc """
  Setup connection details with your Zendesk.

  ## Examples

      iex> Zendex.Connection.setup("http://example.zendesk.com", "ZendeskUser", "Password1")
      %{authentication: "WmVuZGVza1VzZXI6UGFzc3dvcmQx", base_url: "http://example.zendesk.com"}

  """
  @spec setup(String.t, String.t, String.t) :: t
  def setup(base_url, username, password) do
    authentication = Base.encode64("#{username}:#{password}")

    %{base_url: base_url, authentication: authentication}
  end

end
