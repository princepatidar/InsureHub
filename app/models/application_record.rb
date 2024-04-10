# frozen_string_literal: true

class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

  def self.ransackable_attributes(_auth_object = nil)
    column_names
  end

  def self.ransackable_associations(_auth_object = nil)
    reflect_on_all_associations.map { |assoc| assoc.name.to_s }
  end
end
