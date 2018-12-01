defmodule Admissions.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # List all child processes to be supervised
    children = [
      # Start the endpoint when the application starts
      AdmissionsWeb.Endpoint
      # Starts a worker by calling: Admissions.Worker.start_link(arg)
      # {Admissions.Worker, arg},
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Admissions.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @spec config_change(term(), term(), term()) :: term()
  def config_change(changed, _new, removed) do
    AdmissionsWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
