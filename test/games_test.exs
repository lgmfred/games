defmodule GamesTest do
  use ExUnit.Case
  doctest Games
  alias Games

  test "greets the world" do
    assert Games.hello() == :world
  end
end
