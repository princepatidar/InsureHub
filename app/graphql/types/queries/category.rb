# frozen_string_literal: true

# category queries
module Types::Queries::Category
  extend ActiveSupport::Concern

  included do
    field :category, Types::CategoryType, null: false do
      description 'Return single country'
      argument :id, GraphQL::Types::ID, required: true
    end
  end

  def category(id:)
    Category.active.find(id)
  rescue StandardError
    raise GraphQL::ExecutionError, I18n.t('errors.category.not_found')
  end
end
