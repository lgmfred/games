defmodule Games.GuessingGame do
  @moduledoc """
  Guessing game module
  """
  @doc """
  Prompt the player to guess and number and then return "Correct!" or "Incorrect!
  """
  def play do
    answer =
      Enum.random(1..10)
      |> IO.inspect(label: "Answer")

    guess = guess()
    check_guess(guess, answer)
  end

  defp check_guess(guess, answer) do
    if guess == answer do
      IO.puts("Correct!")
    else
      IO.puts("Incorrect!")
      guess = guess()
      check_guess(guess, answer)
    end
  end

  defp guess do
    IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
  end
end
