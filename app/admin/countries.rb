# frozen_string_literal: true

ActiveAdmin.register Country do
  COUNTRYNAME = 'Name'
  TAXNAME = 'Tax Name'
  CURRENCY_SYMBOL = 'Currency Symbol'
  PHONE_NUMBER = 'Phone Number'
  SHORT_FIELD = 'short_field'
  TRANSACTION_FEE = 'Transaction Fee'

  action_item 'Back', only: :show do
    link_to('Back', admin_countries_path)
  end

  filter :name
  filter :currency
  filter :status
  filter :email

  permit_params :country_name, :currency, :currency_symbol, :status, :tax_name, :tax_value, :phone_number, :address, :email, :logo,
                :service_provider_logo, :property_id, :widgetid_en, :widgetid_ar, :service_provider_name, :arabic_service_provider_name, :policy_description, :invoice_prefix
  actions :index, :show, :edit, :update

  index title: 'Country' do
    selectable_column
    column :name
    column :currency
    column :tax_type
    column :tax_value
    column 'Status' do |country|
      status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red')
    end
    column :invoice_prefix
    column PHONE_NUMBER do |country|
      "#{country.country_code}#{country.phone_number}" if country.phone_number.present?
    end
    column 'Address', class: 'truncate', &:address
    column 'Email', &:email
    actions
  end

  show title: 'Show Country' do
    attributes_table do
      row :name
      row :currency
      row :tax_type
      row :tax_name
      row 'Status' do |country|
        status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red')
      end
      row :invoice_prefix
      row PHONE_NUMBER do |country|
        "#{country.code}#{country.phone_number}" if country.phone_number.present?
      end
      row :email
      row :address, class: 'truncate'
      row "Country's Logo" do |resource|
        if resource.logo.attached?
          link_to "#{resource.name}'s logo", url_for(resource.logo), target: '_blank'
        else
          'No logo attached'
        end
      end
      row :service_provider_name
      row :arabic_service_provider_name
      row 'Service Provider logo' do |resource|
        if resource.service_provider_logo.attached?
          link_to resource.name, url_for(resource.service_provider_logo), target: '_blank'
        else
          'No logo attached'
        end
      end
      row :policy_description
    end
  end

  form do |f|
    f.inputs do
      f.input :name, input_html: { readonly: true, class: SHORT_FIELD }
      f.input :currency, input_html: { readonly: true, class: SHORT_FIELD }
      f.input :tax_type
      f.input :tax_value, label: 'Tax value(in %)', as: :string
      f.input :logo, as: :file, label: "Country's Logo", input_html: { accept: 'image/*' }
      f.input :service_provider_name, input_html: { class: SHORT_FIELD }
      f.input :service_provider_logo, as: :file, label: 'Service Provider Logo', input_html: { accept: 'image/*' }
      f.input :invoice_prefix, input_html: { class: SHORT_FIELD }
      f.input :code, input_html: { readonly: true, class: 'with-phone-number country_code' }
      f.input :phone_number, input_html: { class: SHORT_FIELD }
      f.input :address, as: :text, input_html: { class: 'tall-text-area' }
      f.input :email, input_html: { class: SHORT_FIELD }
      f.input :status
      f.input :policy_description # as: :quill_editor, input_html: { data: quill_data }
    end
    f.actions
    script do
      raw <<~JS
        $(document).ready(function() {
          $('input[type="file"]').change(function() {
            var file = this.files[0];
            var maxSize = 4 * 1024 * 1024;

            if (file && file.size > maxSize) {
              alert('Logo file size should not exceed 4 MB.');
              this.value = null;
            }
          });
        });
      JS
    end
  end

  csv do
    column :country_name
    column :currency
    column :currency_symbol
    column :tax_name do |country|
      "#{country&.tax_value} #{country&.default_tax_name}"
    end
    column :status do |country|
      country.status ? 'Active' : 'Inactive'
    end
    column :invoice_prefix
    column :phone_number do |country|
      "#{country.country_code}#{country.phone_number}" if country.phone_number.present?
    end
    column :address, class: 'truncate'
    column :email
  end
end
