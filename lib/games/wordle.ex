defmodule Games.Wordle do
  @moduledoc """
  The Wordle game logic
  """

  @doc """
  Prompt user to guess a five letter word and return a list of color atoms
  """
  def play do
    answer =
      Enum.random(["toast", "tarts", "hello", "beats"])
      |> IO.inspect(label: "Answer")

    guess =
      IO.gets("Enter a five letter word: ")
      |> String.trim()

    feedback(answer, guess)
  end

  @doc """
  Takes two strings and returns a list of color atoms
  """
  def feedback(a, b) do
    list_a = String.split(a, "", trim: true)
    list_b = String.split(b, "", trim: true)

    Enum.zip_reduce(list_a, list_b, [], fn char_a, char_b, acc ->
      cond do
        char_b == char_a -> [:green | acc]
        char_b in list_a -> [:yellow | acc]
        char_b not in list_a -> [:gray | acc]
      end
    end)
    |> Enum.reverse()
  end
end
