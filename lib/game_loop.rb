# frozen_string_literal: true

require_relative 'display'
require_relative 'user_input'
require_relative 'save_game'
require_relative 'load_game'

# Class that runs a loop of the game
class GameLoop
  include Display
  include UserInput
  include SaveGame
  extend LoadGame

  def initialize(secret_word:, incorrect_letters: [], correct_letters: [], incorrect_guesses: 6)
    @secret_word = secret_word
    @correct_letters = correct_letters
    @encoded_word = encode_word
    @incorrect_letters = incorrect_letters
    @incorrect_guesses = incorrect_guesses
  end

  def run_game
    loop do
      beginning_round_messages
      letter_guess = gets_letter_guess(incorrect_letters + correct_letters)
      if save_game?(letter_guess)
        save_game
        break
      end
      analyze_round(letter_guess)
      break if defeat? || win?
    end
  end

  private

  attr_reader :secret_word, :encoded_word, :incorrect_letters, :correct_letters
  attr_accessor :incorrect_guesses

  def beginning_round_messages
    puts display_secret_word(encoded_word)
    puts query_message(:letter_query)
    puts game_message(:save_game)
    puts incorrect_letter_message(incorrect_letters) unless incorrect_letters.empty?
  end

  def encode_word
    secret_word.split('').map do |letter|
      if !correct_letters.nil? && correct_letters.include?(letter)
        letter
      else
        '_'
      end
    end
  end

  def reveal_letters(letter)
    encoded_word.map!.with_index do |element, index|
      letter == secret_word[index] ? letter : element
    end
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
