defmodule Uwsearch.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  alias Elasticlunr.{Index, Pipeline}


  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      UwsearchWeb.Telemetry,
      # Start the Ecto repository
      Uwsearch.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Uwsearch.PubSub},
      {Uwsearch.JsonTable, []},
      # Start Finch
      {Finch, name: Uwsearch.Finch},

      Elasticlunr.IndexManager.child_spec(Index.new(name: "test_index")),
      # Start the Endpoint (http/https)
      UwsearchWeb.Endpoint,
      # Start a worker by calling: Uwsearch.Worker.start_link(arg)

    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Uwsearch.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    UwsearchWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
