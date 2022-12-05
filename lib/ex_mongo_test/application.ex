defmodule ExMongoTest.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application
  # marcus_script_user:s2Gu4QmF05R77Ui1
  @impl true
  def start(_type, _args) do
    import Supervisor.Spec
    children = [
      # Starts a worker by calling: ExMongoTest.Worker.start_link(arg)
      # {ExMongoTest.Worker, arg}
      worker(Mongo, [[
        name: :mongo,
        url: "mongodb+srv://staging-cluster0.f4hbi.gcp.mongodb.net/livello-backend-test",
        username: "marcus_script_user",
        password: "s2Gu4QmF05R77Ui1",
        pool_size: 3
      ]])
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExMongoTest.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
