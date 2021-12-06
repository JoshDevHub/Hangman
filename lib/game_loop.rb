# frozen_string_literal: true

require 'pry-byebug'
require_relative 'display'

# Class that runs a loop of the game
class GameLoop
  attr_accessor :incorrect_guesses
  attr_reader :secret_word, :encoded_word, :incorrect_letters, :correct_letters

  include Display

  def initialize(secret_word:)
    @secret_word = secret_word
    @encoded_word = encode_word
    @correct_letters = []
    @incorrect_letters = []
    @incorrect_guesses = 6
  end

  def run_game
    loop do
      beginning_round_messages
      letter_guess = gets_user_input
      analyze_round(letter_guess)
      break if defeat? || win?
    end
  end

  def beginning_round_messages
    puts display_secret_word(encoded_word)
    puts game_message(:query_letter)
    puts incorrect_letter_message(incorrect_letters) unless incorrect_letters.empty?
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
    input.length == 1 && [*'a'..'z'].include?(input) &&
      !(correct_letters + incorrect_letters).include?(input)
  end

  def analyze_round(guess)
    if secret_word.include?(guess)
      correct_guess(guess)
    else
      incorrect_guess(guess)
    end
  end

  def correct_guess(guess)
    puts game_message(:correct_letter)
    reveal_letters(guess)
    correct_letters << guess
    puts win_message(secret_word) if win?
  end

  def incorrect_guess(guess)
    puts game_message(:incorrect_letter)
    self.incorrect_guesses -= 1
    puts display_remaining_guesses(incorrect_guesses)
    incorrect_letters << guess
    puts lose_message(secret_word) if defeat?
  end

  def defeat?
    incorrect_guesses.zero?
  end

  def win?
    encoded_word.join == secret_word
  end
end
