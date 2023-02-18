defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle
  alias Games.Wordle

  # Green: if the letter is in the word and in the correct spot.
  # Yellow: if the letter is in the word but in the incorrect spot.
  # grey: if the letter is not in the word.

  test "feedback/2 all grey" do
    grey_list = [:grey, :grey, :grey, :grey, :grey]
    assert Wordle.feedback("abcde", "fghij") == grey_list
    assert Wordle.feedback("klmno", "pqrst") == grey_list
  end

  test "feedback/2 all green" do
    green_list = [:green, :green, :green, :green, :green]
    assert Wordle.feedback("abcde", "abcde") == green_list
    assert Wordle.feedback("fghij", "fghij") == green_list
  end

  test "feedback/2 all yellow" do
    yellow_list = [:yellow, :yellow, :yellow, :yellow, :yellow]
    assert Wordle.feedback("abdec", "edcba") == yellow_list
    assert Wordle.feedback("vwxyz", "zxywv") == yellow_list
  end

  test "feedback/2 some grey some green" do
    list1 = [:grey, :green, :grey, :green, :grey]
    list2 = [:green, :green, :green, :grey, :grey]
    assert Wordle.feedback("abcde", "zbxdw") == list1
    assert Wordle.feedback("zbxdw", "zbxvp") == list2
  end

  test "feedback/2 some grey some yellow" do
    list1 = [:grey, :yellow, :grey, :yellow, :grey]
    list2 = [:yellow, :grey, :grey, :yellow, :yellow]
    assert Wordle.feedback("abcde", "zeybw") == list1
    assert Wordle.feedback("zbxdw", "wumbx") == list2
  end

  test "feedback/2 some green some yellow" do
    list1 = [:green, :yellow, :green, :green, :yellow]
    list2 = [:yellow, :green, :green, :yellow, :yellow]
    assert Wordle.feedback("abcde", "aecdb") == list1
    assert Wordle.feedback("zbxdw", "wbxzd") == list2
  end

  test "feedback/2 some grey some green some yellow" do
    list1 = [:grey, :green, :yellow, :green, :yellow]
    list2 = [:yellow, :green, :grey, :yellow, :grey]
    assert Wordle.feedback("abcde", "zbedc") == list1
    assert Wordle.feedback("zbxdw", "wbmxu") == list2
  end

  test "feedback/2 prioritize exact matches give duplicates chars." do
    list1 = [:grey, :green, :green, :yellow, :grey]
    list2 = [:grey, :green, :green, :green, :green]
    assert Wordle.feedback("aaabb", "xaaaa") == list1
    assert Wordle.feedback("ababc", "bbabc") == list2
  end
end
