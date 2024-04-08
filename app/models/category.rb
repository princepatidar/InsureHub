class Category < ApplicationRecord
  enum status: %i[inactive active]

  validates :min_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :min_price_cannot_be_greater_than_max_price

  has_one_attached :logo

  belongs_to :country

  has_many :warranty_categories, dependent: :destroy
  has_many :warranties, through: :warranty_categories
  has_many :stores, dependent: :destroy
  has_many :items, dependent: :destroy
  accepts_nested_attributes_for :warranty_categories, update_only: true, allow_destroy: true

  def self.ransackable_attributes(_auth_object = nil)
    %w[name status country_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    ['country']
  end

  def all_stores
    other_store = Store.new(id: -1, name: 'Other', country_id: country_id, category_id: id)
    stores.active.to_a.push(other_store)
  end

  def price_exceeds?(item_price)
    item_price >= min_price && item_price <= max_price
  end

  private

  def min_price_cannot_be_greater_than_max_price
    return if min_price && max_price && min_price <= max_price

    errors.add(:min_price, 'cannot be greater than max price')
  end
end
