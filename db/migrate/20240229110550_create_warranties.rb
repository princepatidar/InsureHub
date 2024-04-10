# frozen_string_literal: true

class CreateWarranties < ActiveRecord::Migration[7.0]
  def change
    create_table :warranties do |t|
      t.string :name
      t.integer :duration, default: 0
      t.integer :plan, default: 0
      t.boolean :starts_from_purchase_date, default: false
      t.integer :status, default: 1
      t.integer :year, default: 0
      t.integer :month, default: 0
      t.references :country, index: true
      t.timestamps
    end
  end
end
