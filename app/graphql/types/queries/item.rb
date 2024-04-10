# frozen_string_literal: true

# store queries
module Types
  module Queries
    module Item
      extend ActiveSupport::Concern

      included do
        field :items, [Types::ItemType], null: true do
          description 'Return items'
          argument :category_id, GraphQL::Types::ID, required: true
        end
      end

      def items(category_id:)
        category = Category.active.find(category_id)
        category.items.active
      rescue StandardError
        raise GraphQL::ExecutionError, I18n.t('errors.category.not_found')
      end
    end
  end
end
