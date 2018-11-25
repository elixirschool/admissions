defmodule AdmissionsWeb.AuthController do
  @moduledoc """
  A controller to handle out GitHub OAuth callback
  """

  use AdmissionsWeb, :controller

  alias Admissions.Registrar

  plug Ueberauth

  @spec callback(Plug.Conn.t(), map()) :: Plug.Conn.t()
  def callback(%{assigns: %{ueberauth_auth: %{info: info}}} = conn, _params) do
    %{email: email, nickname: nickname} = info

    if Registrar.eligible?(nickname) do
      conn
      |> assign(:email, email)
      |> assign(:nickname, nickname)
      |> redirect(to: "/eligible")
    else
      conn
      |> assign(:nickname, nickname)
      |> redirect(to: "/ineligible")
    end
  end
end
