defmodule PidFileTest do
  use ExUnit.Case
  doctest PidFile

  test "PIDfile gets created and destroyed" do
    {:ok, pid} = PidFile.Worker.start_link(file: "./test1.pid")
    Process.sleep(4000)
    GenServer.stop(pid)
  end
end
