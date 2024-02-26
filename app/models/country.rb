class Country < ApplicationRecord

  enum status: %i[inactive active]
  enum tax_type: %w[VAT GST]
  has_one_attached :service_provider_logo

  def self.ransackable_attributes(auth_object = nil)
    ["address", "code", "created_at", "currency", "email", "id", "invoice_prefix", "name", "phone_number", "policy_description", "service_provider_name", "status", "tax_type", "tax_value", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["service_provider_logo_attachment", "service_provider_logo_blob"]
  end

  def logo
    iso_country = ISO3166::Country.find_country_by_iso_short_name(name)
    short_country_name = iso_country.alpha2.downcase
    "https://flagcdn.com/w320/#{short_country_name}.png"
  end
end
