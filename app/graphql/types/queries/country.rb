# frozen_string_literal: true

# country queries
module Types::Queries::Country
  extend ActiveSupport::Concern

  included do
    field :countries, [Types::CountryType], null: false, description: 'Return a list of active countries'

    field :country, Types::CountryType, null: false do
      description 'Return single country'
      argument :id, GraphQL::Types::ID, required: true
    end
  end

  def countries
    Country.includes(:categories, service_provider_logo_attachment: :blob).active
  end

  def country(id:)
    Country.active.find(id)
  rescue StandardError
    raise GraphQL::ExecutionError, I18n.t('errors.country.not_found')
  end
end
