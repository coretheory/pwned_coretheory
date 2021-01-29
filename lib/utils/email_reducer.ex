defmodule Pwned.Utils.EmailReducer do
  @moduledoc """
  Functions for reducing the email list returned
  from the [breachedaccount](https://haveibeenpwned.com/API/v3#BreachesForAccount) API v3.
  """

  @doc """
  Reduces the list of flattened emails returned from the
  `EmailFlattener.flatten/1` call, and returns the
  integer sum.

  This sum indicates the number of times a given email has
  appeared in data breaches from the [breachedaccount](https://haveibeenpwned.com/API/v3#BreachesForAccount)
  service.

  ## Example
  iex> reduce_email_list(email_list)
        4893554722
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
