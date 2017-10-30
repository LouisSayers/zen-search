class InvalidCommandError < StandardError

  def initialize(msg='Please check your commands directory and ensure the file name matches the class name')
    super
  end

end
