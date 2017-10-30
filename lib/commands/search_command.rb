class Commands::SearchCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Search'
  end

  def execute(prompter, outputter, data_store)
    data_type = retrieve_search_key(prompter)

    if data_type.nil?
      outputter.puts 'You must give a type of key to search for'
    else
      data_value = retrieve_search_value(prompter)
      results = SearchEngine.search(data_store, data_type, data_value)
      outputter.puts results
    end
  end

  private

  def retrieve_search_key(prompter)
    prompter.ask('What type of data are you searching for?', convert: :string)
  end

  def retrieve_search_value(prompter)
    prompter.ask('What value are you searching for?', convert: :string)
  end

end
