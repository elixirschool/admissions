defmodule Admissions.Registrar do
  @moduledoc """
  The Office of Registrar is where prospective applicants are reviewed to determine their eligibility.
  """

  @invite_url "https://elixirschool.slack.com/api/users.admin.invite"

  alias Admissions.Slack
  alias Tentacat.Repositories.Contributors

  defdelegate invite(email), to: Slack

  @doc """
  Check if the provided GitHub nickname is an Elixir School contributor.
  """

  @spec eligible?(String.t()) :: boolean()
  def eligible?(nickname), do: nickname in contributors()

  defp contributors do
    "elixirschool"
    |> Contributors.list("elixirschool")
    |> Enum.map(&Map.get(&1, "login"))
  end
end
