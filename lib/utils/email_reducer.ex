defmodule Pwned.Utils.EmailReducer do
  @moduledoc """
  Functions for reducing the email list returned
  from the [breachedacocunt](https://haveibeenpwned.com/API/v3#BreachesForAccount) API v3.
  """

  @doc """
  Reduces an email list and returns the integer sum.

  ## Example
  iex> reduce_email_list(email_list)
  iex>
  iex> 4893554722
  """
  def reduce_email_list(email_list) do
    email_list
    |> to_string()
    |> String.replace("\"PwnCount\"", "")
    |> String.split(":", trim: true)
    |> Stream.map(fn count -> String.to_integer(count) end)
    |> Enum.reduce(fn count, acc -> count + acc end)
  end
end
