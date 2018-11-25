defmodule AdmissionsWeb.RegistrarController do
  @moduledoc """
  The API interface to the Office of the Registrar
  """
  use AdmissionsWeb, :controller

  @spec index(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def index(conn, _params) do
    render(conn, "index.html")
  end

  @spec eligible(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def eligible(%{assigns: %{email: email, nickname: nickname}} = conn, _params) do
    render(conn, "eligible.html", email: email, nickname: nickname)
  end

  def eligible(conn, _params) do
    redirect(conn, to: "/")
  end

  @spec ineligible(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def ineligible(%{assigns: %{nickname: nickname}}, _params) do
    render(conn, "ineligible.html", nickname: nickname)
  end

  @spec register(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def register(conn, %{"email" => email}) do
    case Registrar.invite(email) do
      :ok ->
        render(conn, "welcome.html")
      {:error, reason} ->
        render(conn, "error.html", reason: reason)
    end
  end
end
