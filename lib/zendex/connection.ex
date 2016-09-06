defmodule Zendex.Connection do

  @type t :: %{base_url: String.t, username: String.t, password: String.t}

  @spec set_up(String.t, String.t, String.t) :: t
  def set_up(base_url, username, password) do
    %{base_url: base_url, username: username, password: password}
  end

end
