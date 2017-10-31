require 'set'

class DataStore

  def initialize
    @data = {}
  end

  def store(name, data)
    data = transform_data(data)

    @data[name] = data
  end

  def file_types
    @data.keys
  end

  def keys_for(file_type)
    error_message = "File type #{file_type} does not exist in the store"
    raise ArgumentError.new(error_message) unless @data.has_key?(file_type)

    keys = @data[file_type].reduce(Set.new) { |set, entry| set.merge(entry.keys) }
    keys.to_a.map(&:to_s).sort
  end

  def select(&block)
    @data.values.flatten.select(&block)
  end

  private

  def transform_data(data)
    case data
      when Array then data
      when Hash then [ data ]
      else raise ArgumentError.new('Invalid data type given for storage')
    end
  end

end
