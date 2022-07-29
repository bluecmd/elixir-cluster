defmodule ClusterAgent do
  use Application

  def listener do
    receive do
      all -> IO.inspect(all)
    end
    listener()
  end

  def sender do
    Process.sleep(1000)
    primary_agent = :global.whereis_name(:primary_agent)
    send(primary_agent, {:hello, node()})
    sender()
  end

  def start(_type, _args) do
    listener = spawn(&listener/0)
    IO.inspect(:global.register_name(:primary_agent, listener))
    spawn(&sender/0)
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
