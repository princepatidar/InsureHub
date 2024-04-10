# frozen_string_literal: true

ActiveAdmin.register ItemWarranty, as: 'PricesAndDiscounts' do
  menu label: 'Prices And Discounts'
  permit_params :warranty_price_percent, :discount_percent, :discount_start_date, :discount_end_date

  index do
    column :item
    column :warranty
    column :warranty_price_percent
    column :discount_percent
    actions
  end

  show title: 'Price & discount' do
    attributes_table do
      row :item
      row :warranty
      row :warranty_price_percent
      row :discount_percent
      row :discount_start_date
      row :discount_end_date
    end
  end

  form title: 'Price & discount' do |f|
    f.inputs do
      f.input :item, input_html: { disabled: true }
      f.input :warranty, input_html: { disabled: true }
      f.input :warranty_price_percent
      f.input :discount_percent
      f.input :discount_start_date
      f.input :discount_end_date
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:item, :warranty)
    end
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_prices_and_discounts_path)
  end

  filter :warranty
  filter :item

  actions :show, :edit, :update, :index
end
