module CategoryHelper
  def get_category(object)
    collection = CATEGORIES.map.with_index { |c, idx| [c, idx] }
    category_dropdown = ActiveAdminCommon.select_attributes(collection).merge(include_blank: 'Select Category')
    return category_dropdown unless object.persisted?

    category_dropdown.merge!(selected: CATEGORIES.find_index(object.category&.name))
  end
end
