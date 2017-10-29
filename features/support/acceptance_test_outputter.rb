class AcceptanceTestOutputter

  def initialize
    @output = []
  end

  def puts(value)
    @output << value
  end

  def next_value
    @output.shift
  end

end
