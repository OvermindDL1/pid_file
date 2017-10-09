defmodule PidFile.Worker do
  @moduledoc """
  """

  use GenServer
  require Logger

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, opts, [name: opts[:name]])
  end


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


  def terminate(reason, file) do
    cleanup_pid(file)
    reason
  end


  defp get_pid() do
    :os.getpid() # charlist
    |> to_string()
    |> String.to_integer()
  end


  defp update_pid(file) do
    pid =
      get_pid()
      |> to_string()
    File.write!(file, pid, [:write, :binary])
  end

  defp cleanup_pid(file) do
    File.rm(file)
  end
end
