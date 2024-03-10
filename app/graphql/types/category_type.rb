# frozen_string_literal: true

module Types
  class CategoryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :min_price, Float
    field :max_price, Float
    field :bg_color, String
    field :text_colour, String
    field :country_id, Integer
    field :status, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :stores, [Types::StoreType], null: true
    field :items, [Types::ItemType], null: true

    def stores
      object.all_stores
    end

    def items
      object.items.active
    end
  end
end
