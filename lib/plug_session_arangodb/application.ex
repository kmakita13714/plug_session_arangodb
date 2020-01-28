defmodule PlugSessionArangodb.Application do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(PlugSessionArangodb.Worker, [PlugSessionArangodb.Worker.pid()])
    ]

    opts = [strategy: :one_for_one, name: PlugSessionArangodb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
