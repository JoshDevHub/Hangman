# frozen_string_literal: true

# Display module that holds methods for outputting text in the CLI
module Display
  def welcome
    'Welcome to a game of Hangman'
  end

  def rules
    <<~HEREDOC
      A secret word will be generated, and you play by guessing letters in an
      attempt to reveal the word. When you guess letters that are in the hidden
      word, the location of these letters within the word will be revealed to you.
      Use this information to help you guess the full word!
      You only have 6 incorrect guesses to spend. Pick your letters wisely!
    HEREDOC
  end

  def game_message(message)
    {
      introduction: "#{welcome}\n\n#{rules}",
      save_game: "Type 'save' to save your game. You can return to it later.",
      query_letter: 'Choose a letter to guess ',
      correct_letter: 'Your guess was correct!',
      incorrect_letter: 'Your guess was incorrect :(',
      play_again: 'Would you like to play again? Y/n '
    }[message]
  end

  def win_message(secret_word)
    "You guessed all of the correct letters in #{secret_word}. Nice job!"
  end

  def lose_message(secret_word)
    "You've lost the game. The secret word was #{secret_word}."
  end

  def incorrect_letter_message(letters_list)
    "Incorrect Letters: #{letters_list.join(' ')}"
  end

  def display_remaining_guesses(number)
    "You have #{number} guesses remaining!"
  end

  def display_secret_word(word)
    word.join(' ')
  end
end
