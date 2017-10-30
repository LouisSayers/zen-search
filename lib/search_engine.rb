class SearchEngine
  class << self
    def search(store, search_type, search_value)
      store.select { |entry| entry[search_type] == search_value }
    end
  end
end
