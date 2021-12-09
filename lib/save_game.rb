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

  def to_yaml
    object = {}
    instance_variables.map { |var| object[var] = instance_variable_get(var) }
    YAML.dump object
  end
end
