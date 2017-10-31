class Commands::ViewSearchKeysCommand
  attr_reader :display_name

  def initialize
    @display_name = 'View search keys'
  end

  def execute(prompter, outputter, data_store)
    file_types = data_store.file_types

    if file_types.empty?
      outputter.puts "Please load a file before executing this command.\n\n"
    else
      file_type = prompter.select('Which file type would you like to see keys for?', file_types)
      keys = data_store.keys_for(file_type)

      outputter.puts "Keys for #{file_type}:\n#{keys.join("\n")}\n\n"
    end
  end

end

