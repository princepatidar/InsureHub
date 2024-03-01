# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :min_price, :max_price, :status, :bg_color, :text_colour, :logo

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
        attached_logo(resource.logo, resource.name)
      end
      row 'Status' do |category|
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
      f.input :logo, as: :file, input_html: { accept: 'image/*' }
      f.input :status
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:country)
    end
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_categories_path)
  end

  filter :country
  filter :name
  filter :status, ActiveAdminCommon.filter_enum_attributes(Category.statuses)

  actions :all, except: :destroy
end
