# frozen_string_literal: true

class AssociateComboWarranties < ActiveRecord::Migration[7.0]
  def change
    add_reference :warranties, :accidental_warranty, null: true
    add_reference :warranties, :extended_warranty, null: true
  end
end
