class Country < ApplicationRecord

  enum status: %i[inactive active]
  enum tax_type: %w[VAT GST]
  has_one_attached :logo
  has_one_attached :service_provider_logo

  def self.ransackable_attributes(auth_object = nil)
    ["address", "code", "created_at", "currency", "email", "id", "invoice_prefix", "name", "phone_number", "policy_description", "service_provider_name", "status", "tax_type", "tax_value", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["logo_attachment", "logo_blob", "service_provider_logo_attachment", "service_provider_logo_blob"]
  end
end
