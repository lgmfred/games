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
    cond do
      guess == answer ->
        IO.puts("Correct!")

      guess > answer ->
        IO.puts("Too High!")
        guess = guess()
        check_guess(guess, answer)

      guess < answer ->
        IO.puts("Too Low!")
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
