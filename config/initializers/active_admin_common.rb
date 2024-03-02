module ActiveAdminCommon
  class << self
    def filter_enum_attributes(data)
      select_attributes(data.keys.map.with_index { |s, idx| [s.humanize, idx] })
    end

    def filter_category
      select_attributes(CATEGORIES).merge(label: 'Category')
    end

    def select_attributes(collection)
      {
        as: :select,
        collection: collection
      }
    end
  end
end
