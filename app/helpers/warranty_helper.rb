module WarrantyHelper
  def warranty_attributes(object)
    object.persisted? ? disable_input : {}
  end

  def plan_attributes(object)
    object.persisted? ? disable_input : { include_blank: false }
  end

  def start_of_warranty_attributes(object)
    return disable_input if object.persisted?

    { input_html: { class: 'warranty_start_period' } }
  end

  def accidental_warranty_attributes(object)
    object.persisted? ? disable_input : { required: true }
  end

  def extended_warranty_attributes(object)
    object.persisted? ? disable_input : { required: true }
  end

  def disable_input
    { input_html: { disabled: true } }
  end
end
