defmodule PidFileTest do

  use ExUnit.Case
  doctest PidFile

  test "PIDfile gets created and destroyed" do
    file = "./test1.pid"
    {:ok, pid} = PidFile.Worker.start_link(file: file)
    assert File.exists?(file)
    Process.sleep(4000)
    GenServer.stop(pid)
    refute File.exists?(file)
  end

end
