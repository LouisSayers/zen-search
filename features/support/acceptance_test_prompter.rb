class AcceptanceTestPrompter

  def initialize
    @actions = []
  end

  def next_action=(value)
    @actions << value
  end

  def enum_select(prompt, options)
    @actions.shift
  end

end
