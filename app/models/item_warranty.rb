# frozen_string_literal: true

class ItemWarranty < ApplicationRecord
  validates_presence_of :warranty_price_percent, :discount_percent
  validates :warranty_price_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  validates :discount_percent, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }
  belongs_to :item
  belongs_to :warranty

  def self.ransackable_attributes(_auth_object = nil)
    %w[warranty_price_percent discount_percent item_id warranty_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[item warranty]
  end
end
