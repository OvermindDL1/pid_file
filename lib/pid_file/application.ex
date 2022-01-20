defmodule PidFile.Application do
  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    worker =
      case Application.get_env(:pid_file, :file, nil) do
        nil ->
          []
        file when is_binary(file) ->
          worker(file)
        {:SYSTEM, env_var} when is_binary(env_var) or is_list(env_var) ->
          get_from_env(env_var)
      end

    children =
      worker

    opts = [strategy: :one_for_one, name: PidFile.Supervisor]
    Supervisor.start_link(children, opts)
  end

  if Version.match?(System.version(), ">= 1.9.0") do
    defp get_from_env(env_var) do
      case System.get_env(env_var) do
        nil -> throw_env(env_var)
        file -> worker(file)
      end
    end
  else
    defp get_from_env(env_var) do
      case :os.getenv(env_var, nil) do
        nil -> throw_env(env_var)
        "" ->  throw_env(env_var)
        '' ->  throw_env(env_var)
        file -> worker(file)
      end
    end
  end

  defp throw_env(env_var) do
    throw "Missing Environment Variable:  #{env_var}"
  end

  defp worker(file), do: [{PidFile.Worker, [file: file]}]

end
