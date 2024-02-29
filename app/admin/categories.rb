# frozen_string_literal: true

include AttachmentHelper
ActiveAdmin.register Category do
  permit_params :min_price, :max_price, :status, :bg_color, :text_colour

  index do
    column :country
    column :name
    column :min_price
    column :max_price
    column('Status') { |category| status_tag(category.active? ? 'Active' : 'Inactive', class: category.active? ? 'green' : 'red') }
    actions
  end

  show do
    attributes_table do
      row :country
      row :name
      row :min_price
      row :max_price
      row :logo do |resource|
        link_to("#{resource.name}'s logo", resource.logo, target: '_blank')
      end
      row 'Status'do |category|
        status_tag(category.active? ? 'Active' : 'Inactive', class: category.active? ? 'green' : 'red')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :country, as: :select, collection: Country.all.pluck(:name, :id),
                        input_html: { disabled: true }
      f.input :name, input_html: { readonly: true }
      f.input :min_price
      f.input :max_price
      f.input :bg_color
      f.input :text_colour
      f.input :logo, as: :file, input_html: { accept: 'image/svg+xml' }
      f.input :status
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:country)
    end
  end

  filter :country, as: :select, collection: -> { Country.all.pluck(:name, :id) }
  filter :name
  filter :status

  actions :all, except: :destroy
end
