class SearchEngine
  class << self
    def search(store, search_key, search_value)
      search_values = [ search_value ]
      search_values << search_value.to_i if integer?(search_value)
      search_values << (search_value == 'true') if boolean?(search_value)

      store.select do |entry|
        search_values.include? entry[search_key]
      end
    end

    private

    def integer?(search_value)
      search_value.to_i.to_s == search_value
    end

    def boolean?(search_value)
      %w(true false).include?(search_value)
    end
  end
end
