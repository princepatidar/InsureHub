# frozen_string_literal: true

module Types
  class WarrantyPlanType < Types::BaseObject
    field :basic, [Types::WarrantyType], null: true
    field :accidental, [Types::WarrantyType], null: true
    field :extended, [Types::WarrantyType], null: true
    field :combo, [Types::WarrantyType], null: true

    def basic
      item.warranties.active.basic if item.warranty_available?(1, purchase_date) && object[:store_id] != -1
    end

    def accidental
      item.warranties.active.accidental if item.warranty_available?(1, purchase_date)
    end

    def extended
      item.warranties.active.extended if item.warranty_available?(6, purchase_date)
    end

    def combo
      item.warranties.active.combo if item.warranty_available?(1, purchase_date)
    end

    private

    def item
      @item ||= object[:item]
    end

    def purchase_date
      @purchase_date ||= object[:purchase_date]
    end
  end
end
