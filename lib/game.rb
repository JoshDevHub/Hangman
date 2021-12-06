# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'display'
require_relative 'game_loop'

# Game Class that holds logic for progressing a game of Hangman
class Game
  attr_reader :dictionary

  include Display

  def initialize(dictionary)
    @dictionary = dictionary
  end

  def play_game
    puts welcome
    puts rules
    loop do
      GameLoop.new(secret_word: dictionary.select_word).run_game
      break unless play_again?
    end
  end

  private

  def play_again?
    puts game_message(:play_again)
    answer = gets.chomp.downcase
    answer == 'y'
  end
end

# method tests
my_game = Game.new(Dictionary.new('5desk.txt')).play_game
