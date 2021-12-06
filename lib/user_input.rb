# frozen_string_literal: true

require_relative 'display'

# Module for getting and managing user inputs
module UserInput
  include Display

  def gets_yes_no_input
    input = gets.chomp.downcase
    return input if %w[y n].include?(input)

    puts "Please respond with 'y' or 'n' only."
    gets_yes_no_input
  end

  def gets_letter_guess(letter_list)
    input = gets.chomp.downcase
    if ![*'a'..'z'].include?(input)
      puts "Please only guess using letters 'A'-'Z'."
      gets_letter_guess(letter_list)
    elsif letter_list.include?(input)
      puts "Eeek - You've already guessed that letter! Please pick a new one."
      gets_letter_guess(letter_list)
    else
      input
    end
  end
end
