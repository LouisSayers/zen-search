class Commands::LoadJsonDataCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Load JSON file'
  end

  def execute(prompter, outputter, data_store)
    path = prompter.ask('Please enter the path of the file', convert: :path)

    json_data = read_json(path)
    file_name = extract_file_name_from(path)

    data_store.store(file_name, json_data)
  end

  private

  def read_json(path)
    file_contents = File.read(path)
    JSON.parse(file_contents)
  end

  def extract_file_name_from(path)
    File.basename(path, '.json')
  end

end
