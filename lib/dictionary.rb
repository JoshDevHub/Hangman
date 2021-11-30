# frozen_string_literal: true

# Dictionary class that holds the dictionary used to select words in the game.
class Dictionary
  attr_reader :dictionary

  def initialize
    @dictionary = File.readlines('5desk.txt')
    clean_dictionary
  end

  def select_word
    random_int = rand(dictionary.length)
    dictionary[random_int]
  end

  def line_chomp
    dictionary.map!(&:chomp)
  end

  def word_length_filter
    dictionary.select! { |word| word.length.between?(5, 12) }
  end

  def clean_dictionary
    line_chomp
    word_length_filter
  end
end

# Test
Dictionary.new.select_word
