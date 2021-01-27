defmodule Pwned do
  @moduledoc """
  Check if your password has been pwned.
  """
  alias Pwned.Utils.EmailFlattener
  alias Pwned.Utils.EmailReducer

  @doc """
  It uses [have i been pwned?](https://haveibeenpwned.com) to verify if a password has appeared in a data breach. In order to protect the value of the source password being searched the value is not sended through the network.

  ## Examples

      iex> Pwned.check_password("P@ssw0rd")
      {:ok, 47205}

      iex> Pwned.check_password("Z76okiy2X1m5PFud8iPUQGqusShCJhg")
      {:ok, false}

  """
  @spec check_password(String.t()) :: {:ok, integer} | {:ok, false} | :error
  def check_password(password) do
    with {head, rest} <- hash(password),
         {:ok, response} <- range_client().get(head),
         {:ok, range} <- parse_password_response(response),
         {:ok, answer} <- do_check(range, rest) do

      {:ok, answer}
    else
      :error -> :error
    end
  end

  @doc """
  This uses API v3 of the [have i been pwned?](https://haveibeenpwned.com) to check
  if an email has appeared in a data breach. It returns the total count of appearances.

  It also requires a purchased hibp-api-key, and implements a 12-factor methodology by
  accessing the hibp-api-key from the system's environment variables.

  ## Examples

    iex> Pwned.check_email("test123@example.com")
    {:pwned_email, 4893554722}

    iex Pwned.check_email("Z76okiy2X1m5PFud8iPUQGqusShCJhg@example.com")
    {:safe_email, "email not pwned"}

  """
  def check_email(email) do
    with head <- email,
         {:pwned_email, response} <- api_client().get(head),
         {:ok, response} <- parse_email_response(response),
         email_list <- EmailFlattener.flatten(response),
         pwned_count <- EmailReducer.reduce_email_list(email_list) do

      {:pwned_email, pwned_count}
    else
      {:safe_email, message} -> {:safe_email, message}

      {:error, message} -> {:error, message}

      _ -> :error
    end
  end

  defp hash(password) do
    :crypto.hash(:sha, password)
    |> Base.encode16()
    |> String.split_at(5)
  end

  defp parse_password_response(response) do
    parsed_response =
      response
      |> String.split("\r\n")
      |> Enum.map(fn line -> String.split(line, ":") end)

    {:ok, parsed_response}
  end

  defp parse_email_response(response) do
    parsed_response = Regex.scan(~r/"PwnCount":\d+/, response)
    {:ok, parsed_response}
  end

  defp do_check(range, rest) do
    case find_hash(range, rest) do
      {:ok, false} -> {:ok, false}
      {:ok, count} -> parse_count(count)
    end
  end

  defp find_hash(range, hash) do
    range
    |> Enum.find(fn item -> List.first(item) == hash end)
    |> handle_hash()
  end

  defp handle_hash(nil), do: {:ok, false}
  defp handle_hash([_hash, count]), do: {:ok, count}

  defp parse_count(count) do
    Integer.parse(count)
    |> handle_count()
  end

  defp handle_count(:error), do: :error
  defp handle_count({count, _rest}), do: {:ok, count}

  defp range_client, do: Application.get_env(:pwned_coretheory, :range_client, Pwned.Range.HTTPClient)
  defp api_client, do: Application.get_env(:pwned_coretheory, :api_client, Pwned.Utils.APIClient)
end
