defmodule GoodEnoughGeoid.App do
  use Application

  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      worker(GoodEnoughGeoid.EGM96_5, [])
    ]

    {:ok, _} = Supervisor.start_link(children, strategy: :one_for_one)
  end
end
