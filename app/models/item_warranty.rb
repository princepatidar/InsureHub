# frozen_string_literal: true

class ItemWarranty < ApplicationRecord
  validates_presence_of :warranty_price_percent
  belongs_to :item
  belongs_to :warranty
end
