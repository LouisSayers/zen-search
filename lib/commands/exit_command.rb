class Commands::ExitCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Exit'
  end

  def execute(prompter, outputter, data_store)
    raise ExitInterrupt
  end

end
