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
  attr_reader :word, :encoded_word, :display

  # TODO: inject class dependencies in main?
  def initialize
    @word = Dictionary.new.select_word
    @encoded_word = encode_word
    @display = Display.new
  end

  def game_loop
    display.welcome
    display.rules
    loop do
      display.query_letter
      display.display_secret_word(encoded_word)
      guess_letter = gets_user_input
      reveal_letter(guess_letter)
    end
  end

  def gets_user_input
    input = gets.chomp.downcase
    return input if valid_letter_input?(input)

    until valid_letter_input?(input)
      puts "Please only input one letter 'A' to 'Z'."
      input = gets.chomp.downcase
    end
    input
  end

  def valid_letter_input?(input)
    input.length == 1 && [*'a'..'z'].include?(input)
  end

  def encode_word
    word.length.times.map { '_' }
  end

  # TODO: might not have to mutate here?
  def reveal_letter(letter)
    encoded_word.map!.with_index do |element, index|
      if letter == word[index]
        letter
      else
        element
      end
    end
  end
end

# method tests
my_game = Game.new.game_loop
