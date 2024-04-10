# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name
      t.integer :status, default: 1
      t.references :country, index: true, null: false
      t.references :category, index: true, null: false
      t.timestamps
    end
  end
end
