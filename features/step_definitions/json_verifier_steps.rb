Then("JSON value with key {string}, value {int} is printed") do |key, value|
  json_file = File.read(File.join(@json_file_path, @json_file_name))
  json = JSON.parse(json_file)

  expected_output = json.find { |entry| entry[key] == value }

  expect(@outputter.next_value).to eq expected_output
end
