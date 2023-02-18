defmodule Games.Menu do
  @moduledoc """
  Games.Menu Documentation

  Prompt the user with a menu to select the game they would like to play.
  """

  @spec display :: :ok
  def display() do
    IO.puts("""
    Select a game:
      1. Guessing Game
      2. Rock Paper Scissors
      3. Wordle
    """)

    choice = IO.gets("Select: ") |> String.trim() |> String.to_integer()

    case choice do
      1 -> Games.GuessingGame.play()
      2 -> Games.RockPaperScissors.play()
      3 -> Games.Wordle.play()
    end
  end
end
