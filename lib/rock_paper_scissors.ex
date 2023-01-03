defmodule Games.RockPaperScissors do
  defguard is_winner(guess1, guess2)
           when {guess1, guess2} in [{:paper, :rock}, {:scissors, :paper}, {:rock, :scissors}]

  def play do
    ai = Enum.random([:rock, :paper, :scissors])
    guess = guess()
    play(ai, guess)
  end

  defp guess do
    IO.gets("(rock/paper/scissors): ")
    |> String.trim()
    |> String.to_atom()
  end

  defp play(guess1, guess2) when is_winner(guess1, guess2) do
    "You lose! #{Atom.to_string(guess1)} beats #{Atom.to_string(guess2)}."
  end

  defp play(guess1, guess2) when is_winner(guess2, guess1) do
    "You win! #{Atom.to_string(guess2)} beats #{Atom.to_string(guess1)}."
  end

  defp play(guess1, guess2) when guess1 == guess2 do
    "It's a tie!"
  end
end
