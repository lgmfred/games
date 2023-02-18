defmodule Games.GuessingGame do
  @moduledoc """
  Games.GuessingGame documentation

  A number guessing game which accepts user input (guess) through the command line
  and provides feedback based on the guess.
  """

  @doc """
  Prompts a player to guess a `number`. If `number` is not passed as an argument,
  it randomly picks a number between 1 and 10 for the player to guess.

  ```elixir
  Games.GuessingGame.play()
  Enter your guess: 6
  Too High!
  Enter your guess: 1
  Too Low!
  Enter your guess: 4
  Too High!
  Enter your guess: 3
  Correct!

  Games.GuessingGame.play(33)
  Enter your guess: 13
  Too Low!
  Enter your guess: 50
  Too High!
  Enter your guess: 33
  Correct!
  ```
  """
  @spec play(nil | integer()) :: no_return()
  def play(number \\ Enum.random(1..10)) do
    guess = guess()
    game_logic(number, guess)

    unless guess == number, do: play(number)
  end

  @spec game_logic(integer(), integer()) :: :ok
  defp game_logic(number, guess) do
    cond do
      guess == number -> "Correct!"
      guess < number -> "Too Low!"
      guess > number -> "Too High!"
    end
    |> IO.puts()
  end

  @spec guess :: integer()
  defp guess do
    IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
  end
end
