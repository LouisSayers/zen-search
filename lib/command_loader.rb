class CommandLoader

  def initialize(commands_dir)
    @commands_dir = commands_dir
    require_all @commands_dir
  end

  def load!
    filename_pattern = File.join(@commands_dir, '*_command.rb')
    file_paths = Dir[filename_pattern]

    file_paths.map do |file_path|
      command_name = file_path[/.*\/(.*)_command.rb\z/, 1]
      command_from(command_name)
    end
  end

  private

  def command_from(command_name)
    camel_case_name = command_name.split('_').map(&:capitalize).join

    begin
      klass = Object.const_get("Commands::#{camel_case_name}Command")
      klass.new
    rescue NameError => ex
      message = "Please ensure command names match their file names.\n#{ex.message}"
      raise InvalidCommandError.new(message)
    end
  end

end
