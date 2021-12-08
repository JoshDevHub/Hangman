# frozen_string_literal: true

require 'yaml'

# Module for save/load functionality
module SaveGame
  def save_game
    yaml_string = to_yaml
    Dir.mkdir('saved_games') unless Dir.exist?('saved_games')
    filename = 'saved_games/saved_hangman.yaml'
    File.open(filename, 'w') do |file|
      file.puts yaml_string
    end
  end

  # def load_game(file_path)
  #   yaml_string = YAML.load File.read(file_path)
  # end

  def to_yaml
    object = {}
    instance_variables.map { |var| object[var] = instance_variable_get(var) }
    YAML.dump object
  end

  # def self.from_yaml(string)
  #   data = YAML.load string
  #   new(secret_word: data[:@secret_word],
  #       incorrect_letters: data[:@incorrect_letters],
  #       correct_letters: data[:@correct_letters],
  #       incorrect_guesses: data[:@incorrect_guesses])
  # end
end
