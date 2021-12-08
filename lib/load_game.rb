# frozen_string_literal: true

# module for loading a saved game
module LoadGame
  def load_game(file_path)
    yaml_string = YAML.load File.read(file_path)
  end

  def from_yaml(data)
    # binding.pry
    new(secret_word: data[:@secret_word],
        incorrect_letters: data[:@incorrect_letters],
        correct_letters: data[:@correct_letters],
        incorrect_guesses: data[:@incorrect_guesses])
  end
end
