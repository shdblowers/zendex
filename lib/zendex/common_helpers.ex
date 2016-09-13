defmodule Zendex.CommonHelpers do
  @moduledoc """
  Contains common helper functions used throughout Zendex.
  """

  def decode_response(%{body: body}), do: Poison.decode!(body)

end
