defmodule Zendex.Connection do

  @type t :: %{base_url: String.t, authentication: binary}

  @spec set_up(String.t, String.t, String.t) :: t
  def set_up(base_url, username, password) do
    authentication = Base.encode64("#{username}:#{password}")

    %{base_url: base_url, authentication: authentication}
  end

end
