defmodule Admissions.Slack do
  @moduledoc """
  A module for interacting with the Slack API
  """

  @invite_url "https://elixirschool.slack.com/api/users.admin.invite"

  @doc """
  """

  @spec invite(String.t()) :: :ok | {:error, reason}
  def invite(email) do
    email
    |> slack_invite()
    |> slack_response()
  end

  defp slack_invite(email) do
    body = %{
      email: email,
      set_active: true,
      token: slack_token()
    }

    HTTPoison.post(@invite_url, Jason.encode!(body), [{"content-type", "application/json"}])
  end

  defp slack_response({:ok, %{body: body}}) do
    case Jason.decode(body) do
      {:ok, %{"ok" => true}} -> :ok
      {:ok, %{"error" => reason}} -> {:error, reason}
    end
  end

  defp slack_response({:error, _reason}) do
    {:error, "unexpected_error"}
  end

  defp slack_token, do: System.get_env("SLACK_TOKEN")
end
