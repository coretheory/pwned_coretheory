defmodule Pwned.Utils.APIClient do
  @moduledoc false

  @api_key System.get_env("HIBP_API_KEY")
  @user_agent Application.get_env(:pwned, :user_agent) || "Pwned Elixir Client"

  def get(head) do
    case HTTPoison.get("https://haveibeenpwned.com/api/v3/breachedaccount/#{head}?truncateResponse=false", [{"hibp-api-key", "#{@api_key}"}, {"user-agent", "#{@user_agent}"}]) do
      {:ok, %HTTPoison.Response{body: body, headers: headers, request: request, status_code: 200}} ->
        {:ok, body}

      {:error, reason} ->
        {:error, reason}
    end
  end
end
