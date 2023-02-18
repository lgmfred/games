defmodule Games do
  @moduledoc """
  Documentation for `Games`.
  """

  @doc """
  Starts the Games CLI. This module is used by Escript.
  """
  def main(_args) do
    Games.Menu.display()
  end
end
