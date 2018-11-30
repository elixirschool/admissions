defmodule AdmissionsWeb.AuthController do
	@moduledoc """
	A controller to handle out GitHub OAuth callback
	"""

	use AdmissionsWeb, :controller

	plug Ueberauth

	@spec callback(Plug.Conn.t(), map()) :: Plug.Conn.t()
	def callback(%{assigns: %{ueberauth_auth: ueberauth_auth}} = conn, _params) do
		%{
			credentials: %{token: token},
			info: %{email: email, nickname: nickname}
		} = ueberauth_auth

    conn
    |> put_session(:github, %{email: email, nickname: nickname, token: token})
    |> redirect(to: Routes.registrar_path(conn, :eligibility))
	end
end
