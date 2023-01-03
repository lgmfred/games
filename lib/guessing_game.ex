defmodule Games.GuessingGame do
  def play do
    number = Enum.random(1..10)
    guess = guess()
    cond do
      guess == number -> IO.puts("Correct!")
      guess > number -> IO.puts("Too High!")
      guess < number -> IO.puts("Too Low!") 
    end
  end

  defp guess do
    IO.gets("Enter your guess: ")
    |> String.trim()
    |> String.to_integer()
  end
end
