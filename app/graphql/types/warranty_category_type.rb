# frozen_string_literal: true

class Types::WarrantyCategoryType < Types::BaseObject
  field :id, ID, null: false
  field :description, String
  field :plan_details_url, String

  def plan_details_url
    return if object.plan_details.blank?

    base_url = 'localhost:3000'
    path = Rails.application.routes.url_helpers.rails_blob_path(object.plan_details)
    "http://#{base_url}#{path}"
  end
end
