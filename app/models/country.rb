class Country < ApplicationRecord
  enum status: %i[inactive active]
  enum tax_type: %w[VAT GST]

  has_one_attached :service_provider_logo

  has_many :categories, dependent: :destroy
  has_many :warranties, dependent: :destroy
  has_many :stores, dependent: :destroy

  def self.ransackable_attributes(_auth_object = nil)
    %w[name currency status email]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['categories']
  end

  def logo
    iso_country = ISO3166::Country.find_country_by_iso_short_name(name)
    short_country_name = iso_country.alpha2.downcase
    "https://flagcdn.com/w320/#{short_country_name}.png"
  end
end
