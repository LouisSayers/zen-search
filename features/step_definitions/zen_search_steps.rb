Given("ZenSearch is loaded") do
  @prompter = AcceptanceTestPrompter.new
  @outputter = AcceptanceTestOutputter.new
  command_loader = CommandLoader.new(@commands_file_path)
  data_store = DataStore.new
  @zen_search = ZenSearch.new(@prompter, @outputter, command_loader, data_store)
end

Given("ZenSearch has run") do
  @zen_search.run
end
