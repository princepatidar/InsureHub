# frozen_string_literal: true

class BuildCategories
  class << self
    def call
      Country.all.find_each do |country|
        %w[Electronics Fashion Furniture Sports].each do |category|
          country.categories.find_or_create_by(name: category)
        end
      end
    end
  end
end
