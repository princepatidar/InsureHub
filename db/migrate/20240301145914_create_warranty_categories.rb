# frozen_string_literal: true

class CreateWarrantyCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :warranty_categories do |t|
      t.text :description
      t.references :category, index: true
      t.references :warranty, index: true

      t.timestamps
    end
  end
end
