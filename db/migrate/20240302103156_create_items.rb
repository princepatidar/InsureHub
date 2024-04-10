# frozen_string_literal: true

class CreateItems < ActiveRecord::Migration[7.0]
  def change
    create_table :items do |t|
      t.string :name
      t.integer :status, default: 1
      t.boolean :is_renewable, default: false
      t.float :depreciation_rate, default: 0.0
      t.references :country, null: false, index: true
      t.references :category, null: false, index: true
      t.timestamps
    end
  end
end
