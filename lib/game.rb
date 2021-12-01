# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'display'

# Game Class that holds logic for progressing a game of Hangman
class Game
  # Pseudo
  # Include display
  # How Game Should Work: the player gets 6 guesses at the word
  # If the player guesses the word before they've used all 6 guesses, they win
  # Else the player loses -- Have complete word displayed to them in this event.
  # Method for revealing letters that the player guesses. Do this comparison here
  #   for state purpose and have it passed to Display.
  attr_reader :word

  def initialize
    @word = Dictionary.new.select_word
  end
end

# method tests
p Game.new.word
