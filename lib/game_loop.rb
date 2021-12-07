# frozen_string_literal: true

require 'pry-byebug'
require 'yaml'
require_relative 'display'
require_relative 'user_input'

# Class that runs a loop of the game
class GameLoop
  attr_accessor :incorrect_guesses
  attr_reader :secret_word, :encoded_word, :incorrect_letters, :correct_letters

  include Display
  include UserInput

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

  def to_yaml
    object = {}
    instance_variables.map { |var| object[var] = instance_variable_get(var) }
    YAML.dump object
  end

  def self.from_yaml(string)
    data = YAML.load string
    self.new(secret_word: data[:@secret_word],
             incorrect_letters: data[:@incorrect_letters],
             correct_letters: data[:@correct_letters],
             incorrect_guesses: data[:@incorrect_guesses])
  end

  def save_game(string)
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = 'saved_games/saved_hangman.yaml'
    File.open(filename, 'w') do |file|
      file.puts string
    end
  end
end

my_game = GameLoop.new(secret_word: 'gamer',
                       incorrect_letters: ['b, y'],
                       correct_letters: ['g'],
                       incorrect_guesses: 4)
my_yaml = my_game.to_yaml
my_game.save_game(my_yaml)
