defmodule AdmissionsWeb.AuthPlug do
  @moduledoc """
  """

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [get_session: 2]

  alias AdmissionsWeb.Router.Helpers

  def init(opts), do: opts

  def call(conn, _opts) do
    if authenticated?(conn) do
      conn
    else
      conn
      |> put_flash(:error, "You must authenticate with GitHub")
      |> redirect(to: Helpers.registrar_path(conn, :index))
    end
  end

  defp authenticated?(conn) do
    conn
    |> get_session(:github)
    |> Map.has_key?(:token)
  end
end
