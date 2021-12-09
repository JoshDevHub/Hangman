# frozen_string_literal: true

# module for loading a saved game
module LoadGame
  def load_game(file_path)
    # binding.pry
    if File.exist?(file_path)
      YAML.load File.read(file_path)
    else
      puts 'A saved game does not exist. Starting a new game...'
    end
  end

  def from_yaml(data)
    new(secret_word: data[:@secret_word],
        incorrect_letters: data[:@incorrect_letters],
        correct_letters: data[:@correct_letters],
        incorrect_guesses: data[:@incorrect_guesses])
  end

  def delete_game(path_to_file)
    File.delete(path_to_file) if File.exist?(path_to_file)
  end
end
