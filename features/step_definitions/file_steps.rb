Given("JSON test files exist at {string}") do |file_path|
  @json_file_path = full_path_for(file_path)
end

Given("commands exist in the {string} directory") do |file_path|
  @commands_file_path = full_path_for(file_path)
end

