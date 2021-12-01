# frozen_string_literal: true

require_relative 'display'

# Class that runs a loop of the game
class GameLoop
  attr_reader :secret_word

  include Display

  def initialize(secret_word:)
    @secret_word = secret_word
    @encoded_word = encode_word
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
end
