defmodule Pwned.Utils.EmailFlattener do
  @moduledoc """
  Functions to flatten nested email lists from
  [breachedaccount](https://haveibeenpwned.com/API/v3#BreachesForAccount) API v3 response.
  """

  def flatten(list) do
    list
    |> Enum.reduce([], &do_flatten/2)
    |> Enum.reverse
  end

  # Private Helper
  # Recursively flatten all items in reverse
  # (Reverse the entire list at the end in the calling method)

  defp do_flatten(nested, acc) when is_list(nested) do
    Enum.reduce(nested, acc, &do_flatten/2)
  end

  defp do_flatten(item, acc) do
    [ item | acc ]
  end
end
