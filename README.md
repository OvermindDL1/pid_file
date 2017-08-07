# PidFile

Manages a simple OS PID file for this BEAM system.

In other words it just makes a file whose sole contents is the Operating System PID of the running BEAM process.

It should also auto-clean old PID files on load, and clear the PID file on a 'proper' shutdown, but even if not a proper
shutdown then it will still clear it properly next time.

Hex:  https://hex.pm/packages/pid_file

## Installation

```elixir
    {:pid_file, "~> 0.1.0"},
```

## Setup

### Global Config

Add one of these to your config for it to be managed globally, replacing the values as necessary:

```elixir
config :pid_file, file: "./my_app.pid"
config :pid_file, file: {:SYSTEM, "PIDFILE"}
```

### Locally Managed

Add the worker to your supervision tree:

```elixir
worker(PidFile.Worker, [[file: "/run/my_app.pid"]])
```
