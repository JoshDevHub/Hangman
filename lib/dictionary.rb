# frozen_string_literal: true

# Dictionary class that holds the dictionary used to select words in the game.
class Dictionary
  attr_reader :dictionary

  def initialize(file_input)
    input = File.readlines(file_input)
    @dictionary = clean_dictionary(input)
  end

  def select_word
    random_int = rand(dictionary.length)
    dictionary[random_int]
  end

  private

  def clean_dictionary(word_list)
    word_list.map(&:chomp).select do |word|
      word.length.between?(5, 12) && word[0] == word[0].downcase
    end
  end
end

# Test
# p Dictionary.new('5desk.txt').dictionary
