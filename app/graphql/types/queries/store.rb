# frozen_string_literal: true

# store queries
module Types
  module Queries
    module Store
      extend ActiveSupport::Concern

      included do
        field :stores, [Types::StoreType], null: true do
          description 'Return stores'
          argument :category_id, GraphQL::Types::ID, required: true
        end
      end

      def stores(category_id:)
        category = Category.active.find(category_id)
        category.all_stores
      rescue StandardError
        raise GraphQL::ExecutionError, I18n.t('errors.category.not_found')
      end
    end
  end
end
