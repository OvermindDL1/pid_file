defmodule PidFile.Worker do

  @moduledoc false

  use GenServer

  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, [name: opts[:name]])
  end

  @impl true
  def init(opts) do
    Process.flag(:trap_exit, true)
    file =
      case opts[:file] do
        file when is_binary(file) -> file
        [_ | _] = iolist -> :erlang.iolist_to_binary(iolist)
        nonfile -> throw {:unsupport_option, __MODULE__, :init, :file, nonfile, opts}
      end
    cleanup_pid(file)
    update_pid(file)
    {:ok, file}
  end

  @impl true
  def terminate(reason, file) do
    cleanup_pid(file)
    reason
  end

  if Version.match?(System.version(), ">= 1.9.0") do
    defp get_pid(), do: System.pid()
  else
    defp get_pid(), do: to_string(:os.getpid())
  end

  defp update_pid(file) do
    File.write!(file, get_pid(), [:write, :binary])
  end

  defp cleanup_pid(file) do
    File.rm(file)
  end

end
