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

    if guess == answer, do: "Correct!", else: "Incorrect!"
  end

  defp guess do
    IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
  end
end
