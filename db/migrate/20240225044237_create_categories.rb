class CreateCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :categories do |t|
      t.string :name
      t.float :min_price, default: 0.0
      t.float :max_price, default: 0.0
      t.string :bg_color, default: '#151828'
      t.string :text_colour, default: '#ffff'
      t.references :country, index: true
      t.integer :status, default: 1
      t.timestamps
    end
  end
end
