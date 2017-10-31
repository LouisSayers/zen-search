require 'tty-prompt'
require 'json'
require_rel 'data_generators'

namespace :performance do
  desc 'Generate JSON file data'
  task generate_json_file: :environment do
    prompt = TTY::Prompt.new
    number_of_entries = prompt.ask('How many json entries should be generated?', convert: :int)
    next if number_of_entries.nil? || number_of_entries < 1

    entries = []
    data_generator = UserDataGenerator.new

    (0...number_of_entries).each_with_index do |index|
      user_id = index + 1
      entries << data_generator.generate(user_id)
    end

    file_name = "performance_users_#{number_of_entries}.json"
    file_location = File.join(File.dirname(__FILE__), '..', '..', 'sample_data', file_name)
    File.write(file_location, JSON.pretty_generate(entries))
  end
end