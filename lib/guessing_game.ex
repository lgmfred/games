defmodule Games.GuessingGame do
  def play do
    number = Enum.random(1..10)
    guess = guess()

    if number == guess do
      "Correct!"
    else
      "Incorrect!"
    end
  end

  defp guess do
    IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
  end
end
