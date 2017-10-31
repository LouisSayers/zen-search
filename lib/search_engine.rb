class SearchEngine
  class << self
    def search(store, search_key, search_value)
      search_values = search_value.nil? ? empty_values : [ search_value ]
      search_values << search_value.to_i if integer?(search_value)
      search_values << (search_value == 'true') if boolean?(search_value)

      store.select do |entry|
        next unless entry.has_key?(search_key)

        value = entry[search_key]

        if value.is_a?(Array)
          array_matches?(search_values, value)
        else
          search_values.include?(value)
        end
      end
    end

    private

    def empty_values
      [ nil, '', [] ]
    end

    def array_matches?(search_values, value)
      return true if value.empty? && search_values.include?([])
      value.any? { |val| search_values.include?(val) }
    end

    def integer?(search_value)
      search_value.to_i.to_s == search_value
    end

    def boolean?(search_value)
      %w(true false).include?(search_value)
    end
  end
end
