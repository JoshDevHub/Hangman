# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'display'
require_relative 'game_loop'
require_relative 'user_input'

# Game Class that holds logic for progressing a game of Hangman
class Game
  attr_reader :dictionary, :save_path

  include Display
  include UserInput
  include LoadGame

  def initialize(dictionary)
    @dictionary = dictionary
    @save_path = 'saved_games/saved_hangman.yaml'
  end

  def play_game
    puts welcome # TODO: Combine these display lines
    puts rules
    loaded_game = load_game_method
    loop do
      game_loop = loaded_game || GameLoop.new(secret_word: dictionary.select_word)
      game_loop.run_game
      loaded_game = nil
      break unless play_again?
    end
  end

  def load_game_method
    return unless File.exist?(save_path)

    return unless load_game?

    file = load_game(save_path)
    GameLoop.from_yaml(file)
  end

  def play_again?
    puts game_message(:play_again)
    answer = gets_yes_no_input
    answer == 'y'
  end

  def load_game?
    puts 'You can start a new game or load a previous one. Would you like to load a game? Y/n'
    gets_yes_no_input == 'y'
  end
end

# method tests
# my_game = Game.new(Dictionary.new('5desk.txt')).play_game
