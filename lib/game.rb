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
  attr_accessor :round

  # TODO: inject class dependencies in main?
  def initialize
    @word = Dictionary.new.select_word
    @encoded_word = encode_word
    @display = Display.new
    @round = 0
  end

  # TODO: Break this down extensively
  def game_loop
    # TODO: Compose this in Display class
    display.welcome
    display.rules
    loop do
      display.query_letter
      display.display_secret_word(encoded_word)
      guess_letter = gets_user_input
      reveal_letter(guess_letter)
      increment_round
      if complete_word?
        # Run Winner Method
        break

      end
    end
  end

  def increment_round
    self.round += 1
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
      letter == word[index] ? letter : element
    end
  end

  def complete_word?
    encoded_word.join == word
  end
end

# method tests
my_game = Game.new.game_loop
