# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'display'

# Game Class that holds logic for progressing a game of Hangman
class Game
  include Display

  def play_game
    display.welcome
    display.rules
    loop do
      GameLoop.new.run_game({ secret_word: Dictionary.new.select_word })
      break unless play_again?
    end
  end

  private

  def play_again?
    Display.game_message(:play_again)
    answer = gets.chomp.downcase
    answer == 'y'
  end
end

# method tests
my_game = Game.new.game_loop
