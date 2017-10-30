class Commands::LoadJsonDataCommand
  attr_reader :display_name

  def initialize
    @display_name = 'Load JSON file'
  end

  def execute(prompter, outputter, data_store)
    path = prompter.ask('Please enter the path of the file', convert: :path)

    if path.nil?
      print_no_file_message(outputter)
    else
      read_and_save_file_data(data_store, outputter, path)
    end
  end

  private

  def read_and_save_file_data(data_store, outputter, path)
    begin
      json_data = read_json(path)
      file_name = extract_file_name_from(path)
      data_store.store(file_name, json_data)
    rescue Errno::ENOENT
      print_no_file_message(outputter)
    rescue JSON::ParserError
      print_json_malformed_message(outputter)
    end
  end

  def print_no_file_message(outputter)
    outputter.puts 'It seems that there is no file at that location...'
  end

  def print_json_malformed_message(outputter)
    outputter.puts 'A problem was encountered reading the JSON file - it seems to be malformed.'
  end

  def read_json(path)
    file_contents = File.read(path)
    JSON.parse(file_contents)
  end

  def extract_file_name_from(path)
    File.basename(path, '.json')
  end

end
