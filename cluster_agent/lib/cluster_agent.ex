defmodule ClusterAgent do
  use Application

  def listener do
    receive do
      all -> IO.inspect(all)
    end
    listener()
  end

  def sender(primary_agent) do
    Process.sleep(1000)
    send(primary_agent, {:hello, node()})
    sender(primary_agent)
  end

  def start(_type, _args) do
    listener = spawn(&listener/0)
    IO.inspect(:global.register_name(:primary_agent, listener))
    spawn(fn -> sender(:global.whereis_name(:primary_agent)) end)
    Supervisor.start_link([], strategy: :one_for_one)
  end
end
