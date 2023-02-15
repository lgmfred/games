defmodule Games.RockPaperScissors do
  @doc """
  Rock paper scissors game module
  """

  def play() do
    ai_choice = Enum.random([:rock, :paper, :scissors])

    guess =
      IO.gets("(rock/paper/scissors): ")
      |> String.trim()
      |> String.to_atom()

    cond do
      ai_choice == guess -> "It's a tie!"
      beats?(ai_choice, guess) -> "You lose! #{ai_choice} beats #{guess}."
      beats?(guess, ai_choice) -> "You win! #{guess} beats #{ai_choice}."
    end
  end

  defp beats?(guess1, guess2) do
    {guess1, guess2} in [
      {:rock, :scissors},
      {:paper, :rock},
      {:scissors, :paper}
    ]
  end
end
