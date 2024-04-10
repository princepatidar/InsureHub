# frozen_string_literal: true

class WarrantyCategory < ApplicationRecord
  validates :description, :plan_details, presence: true

  has_one_attached :plan_details

  belongs_to :category
  belongs_to :warranty
end
