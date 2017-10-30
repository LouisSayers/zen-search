class DataStore

  def initialize
    @data = {}
  end

  def store(name, data)
    @data[name] = data
  end

  def select(&block)
    @data.values.flatten.select(&block)
  end

end
