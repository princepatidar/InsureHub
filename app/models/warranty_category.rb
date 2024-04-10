# frozen_string_literal: true

class WarrantyCategory < ApplicationRecord
  validates_presence_of :description, :plan_details

  has_one_attached :plan_details

  belongs_to :category
  belongs_to :warranty
end
