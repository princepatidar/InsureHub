# frozen_string_literal: true

# country queries
module Types::Queries::Warranty
  extend ActiveSupport::Concern

  included do
    field :warranties, Types::WarrantyPlanType, null: true do
      description 'Return warranties'
      argument :item_id, GraphQL::Types::ID, required: true
      argument :store_id, GraphQL::Types::ID, required: true
      argument :item_price, Float, required: true
      argument :purchase_date, GraphQL::Types::ISO8601Date, required: true
    end
  end

  def warranties(**attributes)
    item = Item.find(attributes[:item_id])

    if item.category.price_exceeds?(attributes[:item_price].to_f)
      raise GraphQL::ExecutionError, I18n.t('errors.category.price_exceeds')
    end

    { item: item, store_id: attributes[:store_id], purchase_date: attributes[:purchase_date] }
  end
end
