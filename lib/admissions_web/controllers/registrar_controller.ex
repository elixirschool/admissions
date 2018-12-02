defmodule AdmissionsWeb.RegistrarController do
  @moduledoc """
  The API interface to the Office of the Registrar
  """
  use AdmissionsWeb, :controller

  require Logger

  alias Admissions.Registrar
  alias AdmissionsWeb.Gettext

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
        Appsignal.Transaction.set_error("Registration Error", reason, [])
        message = translated_message(reason)
        render(conn, "error.html", message: message)
    end
  end

  defp translated_message("already_in_team"), do: Gettext.dgettext("errors", "already_in_team")
  defp translated_message("already_invited"), do: Gettext.dgettext("errors", "already_invited")
  defp translated_message("invalid_email"), do: Gettext.dgettext("errors", "invalid_email")
  defp translated_message("unexpected_error"), do: Gettext.dgettext("errors", "unexpected_error")
end
