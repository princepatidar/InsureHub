# frozen_string_literal: true

class Item < ApplicationRecord
  enum status: %i[inactive active]

  validates_presence_of :depreciation_rate, :name
  validates :depreciation_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  before_save :update_category

  belongs_to :country
  belongs_to :category
  has_many :item_warranties, dependent: :destroy
  has_many :warranties, through: :item_warranties

  def self.list_warranties(country_id, category_name)
    country = Country.find(country_id)
    category = country.categories.find_by(name: category_name)
    category.warranties.pluck(:name, :id)
  rescue StandardError
    []
  end

  def warranty_available?(time_interval, purchase_date)
    purchase_date.to_date >= Date.today - time_interval.month
  end

  private

  def update_category
    self.category_id = country.categories.find_by(name: CATEGORIES[category_id]).id
  end
end
