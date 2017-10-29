class CommandLoader

  def initialize(commands_dir)
    require_all commands_dir
  end

  def load
    [
      Commands::LoadJsonDataCommand.new
    ]
  end

end