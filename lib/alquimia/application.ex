defmodule Alquimia.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      AlquimiaWeb.Telemetry,
      # Start the Ecto repository
      Alquimia.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Alquimia.PubSub},
      # Start Finch
      {Finch, name: Alquimia.Finch},
      # Start the Endpoint (http/https)
      AlquimiaWeb.Endpoint
      # Start a worker by calling: Alquimia.Worker.start_link(arg)
      # {Alquimia.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Alquimia.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    AlquimiaWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
