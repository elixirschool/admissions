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

  pipeline :auth do
    plug AdmissionsWeb.AuthPlug
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", AdmissionsWeb do
    pipe_through :browser

    get "/", RegistrarController, :index
  end

  scope "/", AdmissionsWeb do
    pipe_through [:browser, :auth]

    get "/eligibility", RegistrarController, :eligibility
    get "/thankyou", RegistrarController, :thankyou
    post "/register", RegistrarController, :register
  end

  scope "/auth", AdmissionsWeb do
    pipe_through :browser

    get "/github", AuthController, :request
    get "/github/callback", AuthController, :callback
  end
end
