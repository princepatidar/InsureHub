# frozen_string_literal: true

module Types
  class CountryType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :currency, String
    field :code, String
    field :tax_type, Integer
    field :tax_value, Float
    field :service_provider_name, String
    field :email, String
    field :address, String
    field :phone_number, String
    field :invoice_prefix, String
    field :status, Integer
    field :policy_description, String
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :service_provider_logo, String, null: true
    field :logo, String, null: true

    def service_provider_logo
      return unless object.service_provider_logo.present?

      base_url = 'localhost:3000'
      path = Rails.application.routes.url_helpers.rails_blob_path(object.service_provider_logo)
      "http://#{base_url}#{path}"
    end
  end
end
