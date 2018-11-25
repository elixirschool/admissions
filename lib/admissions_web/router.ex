defmodule AdmissionsWeb.Router do
  use AdmissionsWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Ueberauth
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdmissionsWeb do
    pipe_through :browser

    get "/", RegistrarController, :index
    get "/eligibile", RegistrarController, :eligibile
    get "/ineligibile", RegistrarController, :ineligibile
    get "/thankyou", RegistrarController, :thankyou
  end

  scope "/auth", AdmissionsWeb do
    pipe_through :browser

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
  end
end
