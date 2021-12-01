# frozen_string_literal: true

# Display Class that holds methods for outputting information in the CLI
class Display
  # Pseudo
  # Welcome player to the game
  def welcome
    puts 'Welcome to a game of Hangman'
  end

  def rules
    puts <<~HEREDOC
      You have 6 tries to guess the secret word.
      Pick your letters wisely!
    HEREDOC
  end

  def query_letter
    puts 'Choose a letter to guess '
  end

  def display_secret_word(word)
    puts word.join(' ')
  end
end

Display.new.rules
