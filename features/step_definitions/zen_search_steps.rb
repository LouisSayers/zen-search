Given("ZenSearch is loaded") do
  @prompter = AcceptanceTestPrompter.new
  @outputter = AcceptanceTestOutputter.new
  commands = CommandLoader.new(@commands_file_path).load!
  data_store = DataStore.new
  @zen_search = ZenSearch.new(@prompter, @outputter, commands, data_store)
end

Given("ZenSearch has run") do
  @zen_search.run
end
