# frozen_string_literal: true

class Store < ApplicationRecord
  enum status: { inactive: 0, active: 1 }

  validates :name, presence: true
  belongs_to :country
  belongs_to :category
  before_save :update_category

  private

  def update_category
    self.category_id = country.categories.find_by(name: CATEGORIES[category_id]).id
  end
end
