defmodule Games.Wordle do
  @moduledoc """
    Games.Wordle documentation

    Wordle is a game where players get six attempts to guess a word. They
    are given feedback clues to guess the word.

    * **Green** if the letter is in the word and in the correct spot.
    * **Yellow** if the letter is in the word but in the incorrect spot.
    * **Gray** if the letter is not in the word.
  """
  @type color :: :green | :yellow | :grey

  @words ["toast", "tarts", "hello", "beats"]

  @doc """
  Prompts the user to enter a five letter guess of a word and starts a
  six-attempt recursive loop.

  ## Examples

  ```elixir
  Games.Wordle.play()

  Games.Wordle.play("bitch")
  ```
  """
  @spec play(String.t(), non_neg_integer()) :: :ok
  def play(answer \\ Enum.random(@words), attempt \\ 0)
  def play(answer, 6), do: IO.puts("The answer is #{answer}")

  def play(answer, count) do
    guess =
      IO.gets("Guess the five letter word: ")
      |> String.trim()

    cond do
      answer == guess ->
        length = String.length(guess)
        feedback_list = List.duplicate(:green, length)

        color_feedback(guess, feedback_list)
        |> IO.puts()

      String.length(guess) == String.length(answer) ->
        feedback_list = feedback(answer, guess)

        color_feedback(guess, feedback_list)
        |> IO.puts()

        play(answer, count + 1)

      true ->
        IO.puts("The guess must be a five letter word!")
        play(answer, count + 1)
    end
  end

  @doc """
  Uses IO.ANSI to color the guess string as described by the color list of tuples.

  ## Examples

      iex> Games.Wordle.color_feedback("beach", [:green, :grey, :grey, :green, :green])
      "\e[32mb\e[39m\e[90me\e[39m\e[90ma\e[39m\e[32mc\e[39m\e[32mh\e[39m"

      iex> Games.Wordle.color_feedback("first", [:grey, :grey, :grey, :grey, :grey])
      "\e[90mf\e[39m\e[90mi\e[39m\e[90mr\e[39m\e[90ms\e[39m\e[90mt\e[39m"
  """

  @spec color_feedback(String.t(), [color()]) :: String.t()
  def color_feedback(guess, feedback_list) do
    guess_list = String.split(guess, "", trim: true)

    Enum.zip(guess_list, feedback_list)
    |> Enum.map_join(fn
      {char, :green} -> IO.ANSI.green() <> char <> IO.ANSI.default_color()
      {char, :yellow} -> IO.ANSI.yellow() <> char <> IO.ANSI.default_color()
      {char, :grey} -> IO.ANSI.light_black() <> char <> IO.ANSI.default_color()
    end)
  end

  @doc """
  Takes an `answer` and a `guess` string and returns a list of feedback color atoms.

  ## Examples

      iex> Games.Wordle.feedback("beach", "bitch")
      [:green, :grey, :grey, :green, :green]

      iex> Games.Wordle.feedback("beach", "first")
      [:grey, :grey, :grey, :grey, :grey]

      iex> Games.Wordle.feedback("first", "bitch")
      [:grey, :green, :yellow, :grey, :grey]

      iex> Games.Wordle.feedback("first", "beach")
      [:grey, :grey, :grey, :grey, :grey]
  """

  @spec feedback(String.t() | any(), String.t() | any()) :: [color] | {:error, String.t()}

  def feedback(answer, guess) when is_binary(answer) and is_binary(guess) do
    answer = answer |> String.downcase() |> String.graphemes()
    guess = guess |> String.downcase() |> String.graphemes()

    {answer, guess}
    |> replace_greens()
    |> replace_yellows_and_greys()
  end

  @spec replace_greens({[String.t()], [String.t()]}) ::
          {[String.t() | :green], [String.t() | :green]}
  defp replace_greens({answer, guess}) do
    Enum.zip_reduce(answer, guess, {[], []}, fn
      a, g, {a_acc, g_acc} when a == g ->
        {a_acc ++ [:green], g_acc ++ [:green]}

      a, g, {a_acc, g_acc} ->
        {a_acc ++ [a], g_acc ++ [g]}
    end)
  end

  @spec replace_yellows_and_greys({[String.t() | :green], [String.t() | :green]}) :: [color()]
  defp replace_yellows_and_greys({answer, guess}) do
    remaining_answer_letters = for {a, g} <- Enum.zip(answer, guess), not is_atom(g), do: a

    Enum.reduce(guess, {remaining_answer_letters, []}, fn
      letter_or_atom, {rem_letters, result} ->
        cond do
          Enum.member?(rem_letters, letter_or_atom) ->
            {rem_letters -- [letter_or_atom], [:yellow | result]}

          is_binary(letter_or_atom) ->
            {rem_letters, [:grey | result]}

          true ->
            {rem_letters, [letter_or_atom | result]}
        end
    end)
    |> elem(1)
    |> Enum.reverse()
  end
end
