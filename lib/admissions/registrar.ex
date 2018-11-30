defmodule Admissions.Registrar do
  @moduledoc """
  The Office of Registrar is where prospective applicants are reviewed to determine their eligibility.
  """

  alias Admissions.Slack
  alias Tentacat.{Client, Repositories.Contributors}

  defdelegate invite(email), to: Slack

  @doc """
  Check if the provided GitHub nickname is an Elixir School contributor.
  """

  @spec eligible?(String.t(), String.t()) :: boolean()
  def eligible?(nickname, token), do: nickname in contributors(token)

  defp contributors(token) do
		%{access_token: token}
		|> Client.new()
    |> Contributors.list("elixirschool", "elixirschool")
    |> Enum.map(&Map.get(&1, "login"))
  end
end
