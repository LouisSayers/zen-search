Given("ZenSearch is loaded") do
  @prompter = AcceptanceTestPrompter.new
  @outputter = AcceptanceTestOutputter.new
  command_loader = CommandLoader.new(@commands_file_path)
  @zen_search = ZenSearch.new(@prompter, @outputter, command_loader)
end

Given("ZenSearch has run") do
  @zen_search.run
end
