class Store < ApplicationRecord
  enum status: %i[inactive active]

  validates_presence_of :name
  belongs_to :country
  belongs_to :category
  before_save :update_category

  def self.ransackable_attributes(_auth_object = nil)
    %w[name status country_id category_id]
  end

  def self.ransackable_associations(_auth_object = nil)
    %w[country category]
  end

  private

  def update_category
    self.category_id = country.categories.find_by(name: CATEGORIES[category_id]).id
  end
end
