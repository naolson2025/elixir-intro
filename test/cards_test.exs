defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "create_deck returns a list of 52 cards" do
    deck = Cards.create_deck
    assert length(deck) == 52
  end

  test "shuffling a deck randomizes its order" do
    deck = Cards.create_deck
    assert deck != Cards.shuffle(deck)
  end
end
