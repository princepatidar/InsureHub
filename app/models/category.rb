class Category < ApplicationRecord
  enum status: %i[inactive active]

  validates :min_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :max_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validate :min_price_cannot_be_greater_than_max_price

  has_one_attached :logo

  belongs_to :country

  has_many :warranty_categories
  has_many :warranties, through: :warranty_categories
  accepts_nested_attributes_for :warranty_categories, update_only: true, allow_destroy: true

  def self.ransackable_attributes(auth_object = nil)
    %w[name status country_id]
  end

  def self.ransackable_associations(auth_object = nil)
    ['country']
  end

  private

  def min_price_cannot_be_greater_than_max_price
    return if min_price && max_price && min_price <= max_price

    errors.add(:min_price, 'cannot be greater than max price')
  end
end
