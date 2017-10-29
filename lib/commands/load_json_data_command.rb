class Commands::LoadJsonDataCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Load JSON file'
  end

  def execute(prompter, outputter)
    outputter.puts('Executed booom!')
  end
end
