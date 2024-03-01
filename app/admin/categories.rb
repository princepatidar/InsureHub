# frozen_string_literal: true

ActiveAdmin.register Category do
  permit_params :min_price, :max_price, :status, :bg_color, :text_colour, :logo,
                warranty_categories_attributes: %i[id description plan_details warranty_id _destroy]

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
      row :warranties
    end
  end

  form do |f|
    f.inputs do
      f.input :country, input_html: { disabled: true }
      f.input :name, input_html: { readonly: true }
      f.input :min_price
      f.input :max_price
      f.input :bg_color
      f.input :text_colour
      f.input :logo, as: :file, input_html: { accept: 'image/*' }
      f.input :status
      warranties = Warranty.where(country_id: object.country_id).pluck(:name, :id)
      f.has_many :warranty_categories, heading: 'Warranties', new_record: 'Add New Warranty', allow_destroy: true do |wc|
        wc.input :warranty, as: :select, input_html: { class: 'warranty_dropdown' },
                            collection: warranties,
                            include_blank: 'Select Warranty'
        wc.input :description, as: :quill_editor, input_html: { data: quill_data }
        wc.input :plan_details, label: 'Plan Details', as: :file, input_html: { accept: 'application/pdf' }
      end
    end
    f.actions
  end

  controller do
    before_action :duplicate_warranty, only: :update

    def duplicate_warranty
      return unless DuplicateWarrantyValidator.new(params).call

      flash[:alert] = 'Warranty must be unique'
      render :edit
    end

    def scoped_collection
      super.includes(:country)
    end

    def find_resource
      if %w[edit update].include?(params[:action])
        scoped_collection.includes(warranty_categories: { warranty: {}, plan_details_attachment: :blob }).find(params[:id])
      else
        scoped_collection.find(params[:id])
      end
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
