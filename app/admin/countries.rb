# frozen_string_literal: true

include AttachmentHelper
ActiveAdmin.register Country do
  permit_params :country_name, :currency, :currency_symbol, :status, :tax_type, :tax_value, :phone_number, :address,
                :email, :service_provider_logo, :service_provider_name, :policy_description, :invoice_prefix

  index title: 'Country' do
    selectable_column
    column :name
    column :currency
    column :tax_type
    column :tax_value
    column('Status') do |country|
      status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red')
    end
    column :invoice_prefix
    column('Phone Number') do |country|
      "#{country.country_code}#{country.phone_number}" if country.phone_number.present?
    end
    column('Address', class: 'truncate', &:address)
    column :email
    actions
  end

  show title: 'Show Country' do
    attributes_table do
      row :name
      row :currency
      row :tax_type
      row :tax_value
      row :status do |country|
        status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red')
      end
      row :invoice_prefix
      row :phone_number do |country|
        "#{country.code}#{country.phone_number}" if country.phone_number.present?
      end
      row :email
      row(:address, class: 'truncate')
      row "Country's Logo" do |resource|
        link_to("#{resource.name}'s logo", resource.logo, target: '_blank')
      end
      row :service_provider_name
      row :arabic_service_provider_name
      row 'Service Provider logo' do |resource|
        attached_logo(resource.service_provider_logo, 'Service Provider')
      end
      row :policy_description
    end
  end

  form do |f|
    f.inputs do
      %i[name currency].each { |field| f.input field, input_html: { readonly: true, class: 'short_field' } }
      f.input :tax_type
      f.input :tax_value, label: 'Tax value (in %)', as: :string
      f.input :service_provider_name, input_html: { class: 'short_field' }
      f.input :service_provider_logo, attachment_attributes(object)
      f.input :invoice_prefix, input_html: { class: 'short_field' }
      f.input :code, input_html: { readonly: true, class: 'with_phone_number country_code' }
      f.input :phone_number, input_html: { class: 'short_field' }
      f.input :address, as: :text, input_html: { class: 'tall_text_area' }
      f.input :email, input_html: { class: 'short_field' }
      f.input :status
      f.input :policy_description, as: :quill_editor, input_html: { data: quill_data }
    end
    f.actions
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_countries_path)
  end

  filter :name
  filter :currency
  filter :status, ActiveAdminCommon.filter_enum_attributes(Country.statuses)
  filter :email

  actions :index, :show, :edit, :update
end
