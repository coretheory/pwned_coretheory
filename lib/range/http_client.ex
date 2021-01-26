defmodule Pwned.Range.HTTPClient do
  @moduledoc """
  Uses the API V3 pwnedpasswords to check if
  a password has been pwned.

  Updated to include padding to increase privacy.
  """
  @behaviour Pwned.Range

  def get(head) do
    case HTTPoison.get("https://api.pwnedpasswords.com/range/#{head}", [{"Add-Padding", "true"}]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        {:ok, body}

      _ ->
        :error
    end
  end
end
