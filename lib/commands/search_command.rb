class Commands::SearchCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Search'
  end

  def execute(prompter, outputter, data_store)
    data_type = prompter.ask('What type of data are you searching for?', convert: :string)
    data_value = prompter.ask('What value are you searching for?', convert: :string)

    results = SearchEngine.search(data_store, data_type, data_value)
    outputter.puts results
  end

end
