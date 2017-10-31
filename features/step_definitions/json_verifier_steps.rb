Then("JSON value with key {string}, value {int} is printed") do |key, value|
  json_file = File.read(File.join(@json_file_path, @json_file_name))
  json = JSON.parse(json_file)

  json_data = json.select { |entry| entry[key] == value }
  pretty_output = JSON.pretty_generate(json_data)
  expected_output = "#{pretty_output}\n\n"

  expect(@outputter.next_value).to eq expected_output
end
