# frozen_string_literal: true

require_relative 'lib/game'
require_relative 'lib/dictionary'

# script to run the game
dict = Dictionary.new('5desk.txt')
Game.new(dict).play_game
