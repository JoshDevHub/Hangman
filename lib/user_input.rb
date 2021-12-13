# frozen_string_literal: true

require_relative 'display'

# Module for getting and managing user inputs
module UserInput
  include Display

  def gets_yes_no_input
    input = gets.chomp.downcase
    return input if %w[y n].include?(input)

    puts error_message(:yes_no_error)
    gets_yes_no_input
  end

  def gets_letter_guess(letter_list)
    input = gets.chomp.downcase
    return input if save_game?(input) || letter?(input) && no_repeat_letters?(input, letter_list)

    gets_letter_guess(letter_list)
  end

  def save_game?(input)
    input == 'save'
  end

  def letter?(input)
    return true if [*'a'..'z'].include?(input)

    puts error_message(:letter_error)
    false
  end

  def no_repeat_letters?(input, letter_list)
    return true unless letter_list.include?(input)

    puts error_message(:repeat_error)
    false
  end
end
