module Commands end

class ZenSearch

  def initialize(prompter, outputter, commands, data_store)
    @prompter = prompter
    @outputter = outputter
    @commands = commands
    @data_store = data_store
  end

  def run
    begin
      loop do
        command_mappings = commands_by_name
        selected_option = @prompter.enum_select('Please select an option', command_mappings.keys)
        command_mappings[selected_option].execute(@prompter, @outputter, @data_store)
      end
    rescue TTY::Reader::InputInterrupt, ExitInterrupt
      @outputter.puts "\nThanks for using ZenSearch!"
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
