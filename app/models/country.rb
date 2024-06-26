# frozen_string_literal: true

class Country < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  enum tax_type: { 'VAT' => 0, 'GST' => 1 }

  has_one_attached :service_provider_logo

  has_many :categories, dependent: :destroy
  has_many :warranties, dependent: :destroy
  has_many :stores, dependent: :destroy
  has_many :items, dependent: :destroy

  def logo
    iso_country = ISO3166::Country.find_country_by_iso_short_name(name)
    short_country_name = iso_country.alpha2.downcase
    "https://flagcdn.com/w320/#{short_country_name}.png"
  end
end
