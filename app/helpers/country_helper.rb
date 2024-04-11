# frozen_string_literal: true

module CountryHelper
  def get_country(object)
    return { input_html: { disabled: true } } if object.persisted?

    {
      as: :select,
      collection: Country.pluck(:name, :id),
      include_blank: 'Select Country'
    }
  end
end
