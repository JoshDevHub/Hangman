# frozen_string_literal: true

require_relative 'display'

# Class that runs a loop of the game
class GameLoop
  attr_accessor :guessed_letters, :incorrect_guesses
  attr_reader :secret_word, :encoded_word

  include Display

  def initialize(secret_word:)
    @secret_word = secret_word
    @encoded_word = encode_word
    @guessed_letters = []
    @incorrect_guesses = 6
  end

  def run_game
    loop do
      puts display_secret_word(encoded_word)
      puts game_message(:query_letter)
      letter_guess = gets_user_input
      guessed_letters << letter_guess
      analyze_round(letter_guess)
      break if defeat? || win?
    end
  end

  def encode_word
    secret_word.length.times.map { '_' }
  end

  def reveal_letters(letter)
    encoded_word.map!.with_index do |element, index|
      letter == secret_word[index] ? letter : element
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

  def analyze_round(guess)
    if secret_word.include?(guess)
      reveal_letters(guess)
      win?
    else
      self.incorrect_guesses -= 1
      puts display_remaining_guesses(incorrect_guesses)
      defeat?
    end
  end

  def defeat?
    incorrect_guesses.zero?
  end

  def win?
    encoded_word.join(' ') == secret_word
  end
end
