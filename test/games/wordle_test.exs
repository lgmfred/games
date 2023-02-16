defmodule Games.WordleTest do
  use ExUnit.Case
  doctest Games.Wordle
  alias Games.Wordle

  # Green: if the letter is in the word and in the correct spot.
  # Yellow: if the letter is in the word but in the incorrect spot.
  # Gray: if the letter is not in the word.

  test "feedback/2 all gray" do
    gray_list = [:gray, :gray, :gray, :gray, :gray]
    assert Wordle.feedback("abcde", "fghij") == gray_list
    assert Wordle.feedback("klmno", "pqrst") == gray_list
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

  test "feedback/2 some gray some green" do
    list1 = [:gray, :green, :gray, :green, :gray]
    list2 = [:green, :green, :green, :gray, :gray]
    assert Wordle.feedback("abcde", "zbxdw") == list1
    assert Wordle.feedback("zbxdw", "zbxvp") == list2
  end

  test "feedback/2 some gray some yellow" do
    list1 = [:gray, :yellow, :gray, :yellow, :gray]
    list2 = [:yellow, :gray, :gray, :yellow, :yellow]
    assert Wordle.feedback("abcde", "zeybw") == list1
    assert Wordle.feedback("zbxdw", "wumbx") == list2
  end

  test "feedback/2 some green some yellow" do
    list1 = [:green, :yellow, :green, :green, :yellow]
    list2 = [:yellow, :green, :green, :yellow, :yellow]
    assert Wordle.feedback("abcde", "aecdb") == list1
    assert Wordle.feedback("zbxdw", "wbxzd") == list2
  end

  test "feedback/2 some gray some green some yellow" do
    list1 = [:gray, :green, :yellow, :green, :yellow]
    list2 = [:yellow, :green, :gray, :yellow, :gray]
    assert Wordle.feedback("abcde", "zbedc") == list1
    assert Wordle.feedback("zbxdw", "wbmxu") == list2
  end
end
