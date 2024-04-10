# frozen_string_literal: true

class Types::ItemType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
  field :status, Integer
  field :is_renewable, Boolean
  field :depreciation_rate, Float
  field :country_id, Integer, null: false
  field :category_id, Integer, null: false
end
