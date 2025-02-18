defmodule ChatApp.Server do
  require Logger
  use GenServer

  def start_link(port) do
    GenServer.start_link(__MODULE__, port, name: :chat_server)
  end

  def init(port) do
    {:ok, listening_socket} = :gen_tcp.listen(port, [:binary, active: true])
    Logger.info "Accepting connections on port #{port}..."

    GenServer.cast(:socket_coordinator, {:listener_ready, listening_socket})

    {:ok, listening_socket}
  end
end