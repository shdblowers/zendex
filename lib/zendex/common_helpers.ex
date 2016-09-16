defmodule Zendex.CommonHelpers do
  @moduledoc """
  Contains common helper functions used throughout Zendex.
  """

  def decode_response(%{body: body}), do: Poison.decode!(body)

  def get_headers(authentication) do
    [{"Authorization", "Basic #{authentication}"}]
  end

  def get_headers(authentication, %{content_type: :json}) do
    get_headers(authentication) ++ [{"Content-Type", "application/json"}]
  end
end
