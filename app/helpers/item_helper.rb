# frozen_string_literal: true

module ItemHelper
  def item_attributes(object)
    object.persisted? ? disable_input : {}
  end

  def country_attributes(object)
    return disable_input if object.persisted?

    { include_blank: 'Select Country' }
  end

  def warranties_attributes(object)
    return attributes([], '') unless object.persisted? || object.item_warranties.present?

    collection = object.class.list_warranties(object.country_id, object.category.name)
    attributes(collection, 'Warranties').merge(selected: object.warranties.pluck(:id))
  end

  def attributes(collection, label)
    { as: :check_boxes, collection: collection, label: label }
  end

  def disable_input
    { input_html: { diabled: true } }
  end
end
