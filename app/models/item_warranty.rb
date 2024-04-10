# frozen_string_literal: true

class ItemWarranty < ApplicationRecord
  validates :warranty_price_percent, :discount_percent, presence: true
  validates :warranty_price_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :discount_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  belongs_to :item
  belongs_to :warranty
end
