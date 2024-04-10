class Store < ApplicationRecord
  enum status: %i[inactive active]

  validates_presence_of :name
  belongs_to :country
  belongs_to :category
  before_save :update_category

  private

  def update_category
    self.category_id = country.categories.find_by(name: CATEGORIES[category_id]).id
  end
end
