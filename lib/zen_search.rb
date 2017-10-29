module Commands end

class ZenSearch

  def initialize(prompter, command_loader)
    @prompter = prompter
    @commands = command_loader.load
  end

  def run
    exit_key = 'Exit'
    command_mappings = commands_by_name.merge(exit_key => nil)

    loop do
      selected_option = @prompter.enum_select('Please select an option', command_mappings.keys)
      break if selected_option == exit_key

      command_mappings[selected_option].execute
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
