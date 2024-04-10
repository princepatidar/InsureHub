# frozen_string_literal: true

class Warranty < ApplicationRecord
  enum status: { inactive: 0, active: 1 }
  enum plan: { basic: 0, accidental: 1, extended: 2, combo: 3 }

  validates :name, presence: true
  validates :duration, numericality: { greater_than: 0 }, unless: -> { combo? }
  validates :year, numericality: { greater_than_or_equal_to: 0 }
  validates :month, numericality: { greater_than_or_equal_to: 0, less_than: 13 }
  validate :combo_warranties
  validate :validate_year_and_month

  belongs_to :country
  belongs_to :accidental_warranty, class_name: 'Warranty', optional: true
  belongs_to :extended_warranty, class_name: 'Warranty', optional: true
  has_many :warranty_categories, dependent: :destroy
  has_many :categories, through: :warranty_categories
  has_many :item_warranties, dependent: :destroy
  has_many :items, through: :item_warranties

  def self.combo_warranties(country_id)
    country = Country.find(country_id)

    {
      accidental: country.warranties.accidental.pluck(:name, :id),
      extended: country.warranties.extended.pluck(:name, :id)
    }
  end

  def waiting_period
    year_part = "#{year} year(s)" if year.present? && !year.zero?
    month_part = "#{month} month(s)" if month.present? && !month.zero?

    [year_part, month_part].compact.join(' & ')
  end

  private

  def combo_warranties
    return unless combo?

    errors.add(:accidental_warranty_id, 'must exist') unless accidental_warranty_id?
    errors.add(:extended_warranty_id, 'must exist') unless extended_warranty_id?
  end

  def validate_year_and_month
    return if starts_from_purchase_date? || combo?
    return if year.positive? || month.positive?

    errors.add(:year, 'should be greater than zero')
    errors.add(:month, 'should be greater than zero')
  end
end
