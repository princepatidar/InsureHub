# frozen_string_literal: true

module Types
  class WarrantyType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :duration, Integer
    field :plan, Integer
    field :starts_from_purchase_date, Boolean
    field :status, Integer
    field :year, Integer
    field :month, Integer
    field :country_id, Integer
    field :accidental_warranty_id, Integer
    field :extended_warranty_id, Integer
  end
end
