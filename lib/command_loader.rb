class CommandLoader

  def initialize(commands_dir)
    @commands_dir = commands_dir
    require_all @commands_dir
  end

  def load
    [
      Commands::LoadJsonDataCommand.new,
      Commands::SearchCommand.new
    ]
  end

end
