defmodule Mix.Tasks.Build do
  use Mix.Task

  @impl Mix.Task
  def run(_args) do
    {microseconds, :ok} = :timer.tc(fn -> Blog.build() end)
    milliseconds = microseconds / 1000
    IO.puts("Build in  #{milliseconds}")
  end
end
