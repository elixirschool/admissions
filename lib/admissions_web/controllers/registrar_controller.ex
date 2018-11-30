defmodule AdmissionsWeb.RegistrarController do
  @moduledoc """
  The API interface to the Office of the Registrar
  """
  use AdmissionsWeb, :controller

  require Logger

  alias Admissions.Registrar

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec eligibility(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def eligibility(conn, _params) do
    %{email: email, nickname: nickname, token: token} = get_session(conn, :github)

    template = if Registrar.eligible?(nickname, token), do: "eligible.html", else: "ineligible.html"

    render(conn, template, %{email: email, nickname: nickname})
  end

  @spec register(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def register(conn, %{"email" => email}) do
    case Registrar.invite(email) do
      :ok ->
        render(conn, "welcome.html")
      {:error, reason} ->
        Logger.error(inspect(reason))
        render(conn, "error.html")
    end
  end
end
