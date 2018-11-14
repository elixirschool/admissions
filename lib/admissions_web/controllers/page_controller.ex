defmodule AdmissionsWeb.PageController do
  use AdmissionsWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
