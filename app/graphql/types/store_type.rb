# frozen_string_literal: true

class Types::StoreType < Types::BaseObject
  field :id, ID, null: false
  field :name, String
  field :status, Integer
  field :country_id, Integer
  field :category_id, Integer
end
