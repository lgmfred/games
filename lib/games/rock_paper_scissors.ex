defmodule Games.RockPaperScissors do
  @moduledoc """
  Games.RockPaperScissors documentation

  Rock paper scissors game where a player plays against an AI (not what
  you think, just the computer) which randomly chooses `"rock"`, `"paper"`,
  or `"scissors"`.
  """
  @wins [{:rock, :scissors}, {:paper, :rock}, {:scissors, :paper}]

  @doc """
  Prompt the player for a choice of `"rock"`, `"paper"`, or `"scissors"` and
  display the outcome of the game.

  ## Example

  ```elixir
  Games.RockPaperScissors.play()
  (rock/paper/scissors): rock
  "You win! rock beats scissors."

  Games.RockPaperScissors.play()
  (rock/paper/scissors): paper
  "You win! paper beats rock.

  Games.RockPaperScissors.play()
  (rock/paper/scissors): scissors
  "It's a tie!"
  ```
  """
  @spec play :: :ok
  def play() do
    ai_choice = Enum.random([:rock, :paper, :scissors])

    guess =
      IO.gets("(rock/paper/scissors): ")
      |> String.trim()
      |> String.to_atom()

    rps(ai_choice, guess)
  end

  @doc """
  Takes two arguments `player1_choice` and `player2_choice` and determines
  if player 2 wins or not.

  ## Example

      iex> Games.RockPaperScissors.rps(:rock, :rock)
      "It's a tie!"

      iex> Games.RockPaperScissors.rps(:paper, :scissors)
      "You win! scissors beats paper."

      iex> Games.RockPaperScissors.rps(:rock, :scissors)
      "You lose! rock beats scissors."
  """
  @spec rps(atom(), atom()) :: :ok
  def rps(choice1, choice2) do
    cond do
      choice1 == choice2 -> "It's a tie!"
      {choice1, choice2} in @wins -> "You lose! #{choice1} beats #{choice2}."
      {choice2, choice1} in @wins -> "You win! #{choice2} beats #{choice1}."
    end
    |> IO.puts()
  end
end
