defmodule Pwned.Utils.APIClient do
  @moduledoc false

  @hibp_api_key System.get_env("HIBP_API_KEY")
  @user_agent Application.get_env(:ct_pwned, :user_agent) || "Pwned Elixir Client"

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
