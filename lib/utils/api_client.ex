defmodule Pwned.Utils.APIClient do
  @moduledoc """
  Checks if a given email has been pwned using
  the HaveIBeenPwned? API v3 [breachedaccounts service](https://haveibeenpwned.com/API/v3#BreachesForAccount).

  Requires a purchased [hibp-api_key](https://haveibeenpwned.com/API/Key).
  """

  @hibp_api_key System.get_env("HIBP_API_KEY")
  @user_agent Application.compile_env(:pwned_coretheory, :user_agent, "Pwned by Core Theory Elixir Client")

  def get(head) do
    case HTTPoison.get("https://haveibeenpwned.com/api/v3/breachedaccount/#{head}?truncateResponse=false", [{"hibp-api-key", @hibp_api_key}, {"user-agent", @user_agent}]) do
      {:ok, %HTTPoison.Response{body: body, headers: _headers, request: _request, status_code: 200}} ->
        {:pwned_email, body}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 404}} ->
        {:safe_email, "email not pwned"}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 400}} ->
        {:error, "bad request"}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 401}} ->
        {:error, "unauthorized api key"}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 403}} ->
        {:error, "forbidden user agent"}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 429}} ->
        {:error, "too many requests"}

      {:ok, %HTTPoison.Response{body: _, headers: _headers, request: _request, status_code: 503}} ->
        {:error, "service unavailable"}

      {:error, %HTTPoison.Error{id: nil, reason: :timeout}} ->
        {:error, "request_timeout"}

      _ ->
        :error
    end
  end
end
