defmodule Cards do
  @moduledoc """
  This module contains functions for creating and manipulating decks of cards.
  """

  @doc """
  Creates a deck of cards. Returns a list of strings.
  """
  def create_deck do
    values = [
      "Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten",
     "Jack", "Queen", "King"
    ]
    suits = ["Clubs", "Diamonds", "Hearts", "Spades"]

    for suit <- suits, value <- values do
      "#{value} of #{suit}"
    end
  end

  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Determines whether a deck contains a given card. Returns a boolean.

    ## Examples

        iex> deck = Cards.create_deck
        iex> Cards.contains?(deck, "Ace of Clubs")
        true
  """
  def contains?(deck, card) do
    Enum.member?(deck, card)
  end

  @doc """
  Deals a hand of cards from a deck. Returns a tuple with the first element being
  the hand and the second element being the remaining deck.

        iex> deck = Cards.create_deck
        iex> {hand, deck} = Cards.deal(deck, 5)
        iex> hand
        ["Ace of Clubs", "Two of Clubs", "Three of Clubs", "Four of Clubs", "Five of Clubs"]
  """
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    # File.read returns a tuple with the first element being an atom
    # indicating the status of the operation
    # This is a good example of pattern matching
    # and an alternative to using if statements
    case File.read(filename) do
      { :ok, binary } -> :erlang.binary_to_term(binary)
      { :error, _reason } -> "Error reading file"
    end
  end

  def create_hand(hand_size) do
    # deck = Cards.create_deck
    # shuffled_deck = Cards.shuffle(deck)
    # hand = Cards.deal(shuffled_deck, hand_size)

    # The above code can be refactored to the following
    # |> is the pipe operator and is used to chain functions
    # it will automatically pass the return value of the previous fn down the chain
    Cards.create_deck
    |> Cards.shuffle
    |> Cards.deal(hand_size)
  end
end
