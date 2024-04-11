# frozen_string_literal: true

class DuplicateWarrantyValidator
  def initialize(params)
    @params = params
  end

  def call
    warranty_ids = @params.dig(:category, :warranty_categories_attributes)&.values&.pluck('warranty_id')
    !(warranty_ids.nil? || warranty_ids.uniq.length == warranty_ids.length)
  end
end
