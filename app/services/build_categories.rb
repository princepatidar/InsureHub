class BuildCategories
  class << self
    def call
      ISO3166::Country.all.each do |iso_country|
        Country.find_or_create_by(name: iso_country.name) do |db_country|
          db_country.currency = iso_country.currency_code
          db_country.code = "+#{iso_country.country_code}"
        end
      end
    end
  end
end
