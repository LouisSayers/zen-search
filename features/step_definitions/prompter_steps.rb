Given("the {string} option is chosen") do |option|
  @prompter.next_action = option
end

Given("the {string} file is loaded") do |file_name|
  @json_file_name = file_name
  @prompter.next_action = file_name
end

Given("the search term {string} is entered") do |search_term|
  @prompter.next_action = search_term
end

Given("the search value {string} is entered") do |search_value|
  @prompter.next_action = search_value
end

Given("the exit command has been given") do
  @prompter.next_action = 'Exit'
end
