module Commands end

class ZenSearch

  def initialize(prompter, outputter, command_loader, data_store)
    @prompter = prompter
    @outputter = outputter
    @commands = command_loader.load
    @data_store = data_store
  end

  def run
    exit_key = 'Exit'
    command_mappings = commands_by_name.merge(exit_key => nil)

    loop do
      selected_option = @prompter.enum_select('Please select an option', command_mappings.keys)
      break if selected_option == exit_key

      command_mappings[selected_option].execute(@prompter, @outputter, @data_store)
    end
  end

  private

  def commands_by_name
    @commands.reduce({}) do |command_mappings, command|
      command_mappings[command.display_name] = command
      command_mappings
    end
  end

end
