class DuplicateWarrantyValidator
  def initialize(params)
    @params = params
  end

  def call
    warranty_ids = @params.dig(:category, :warranty_categories_attributes)&.values&.map do |nested_params|
      nested_params['warranty_id']
    end
    is_unique = warranty_ids.nil? || warranty_ids.uniq.length == warranty_ids.length
    is_unique ? false : true
  end
end
