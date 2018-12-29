defmodule AdmissionsWeb.AuthPlug do
  @moduledoc """
  A simple plug to ensure we have a session populated with our expected information.
  """

  @behaviour Plug

  import Phoenix.Controller, only: [put_flash: 3, redirect: 2]
  import Plug.Conn, only: [get_session: 2]

  alias AdmissionsWeb.Router.Helpers

  @impl true
  def init(opts), do: opts

  @impl true
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
    with github when is_map(github) <- get_session(conn, :github)
    do
      Map.has_key?(github, :token)
    else
      _ -> false
    end
  end
end
