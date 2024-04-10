# frozen_string_literal: true

ActiveAdmin.register Warranty do
  permit_params :name, :country_id, :status, :duration, :starts_from_purchase_date, :plan, :year, :month,
                :accidental_warranty_id, :extended_warranty_id

  index do
    column :country
    column :name
    column('Plan') { |warranty| warranty.plan.capitalize }
    column('Status') do |warranty|
      status_tag(warranty.active? ? 'Active' : 'Inactive', class: warranty.active? ? 'green' : 'red')
    end
    actions
  end

  show title: 'Show Warranty' do
    attributes_table do
      row :country
      row :name
      row :plan do
        resource.plan.capitalize
      end
      row :status do
        status_tag(resource.active? ? 'Active' : 'Inactive', class: resource.active? ? 'green' : 'red')
      end
      if resource.combo?
        row :accidental_warranty
        row :extended_warranty
      else
        row 'Duration of Warranties (In years)' do
          resource.duration
        end
        row :starts_from_purchase_date

        unless resource.starts_from_purchase_date?
          row 'Start of warranty plan(n year after purchase date)' do
            resource.waiting_period
          end
        end
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :country, get_country(object)
      f.input :name, warranty_attributes(object)
      f.input :plan, plan_attributes(object)
      f.input :status, include_blank: false
      f.inputs class: 'non_combo_warranty_inputs' do
        f.input :duration, warranty_attributes(object)
        f.input :starts_from_purchase_date, warranty_attributes(object)
        f.inputs 'Start of the Warranty Plans (N year after purchase date)', class: 'start_date_fields' do
          f.input :year, start_of_warranty_attributes(object)
          f.input :month, start_of_warranty_attributes(object)
        end
      end
      f.inputs 'Combo Warranty', class: 'combo_warranty_inputs' do
        f.input :accidental_warranty, accidental_warranty_attributes(object)
        f.input :extended_warranty, extended_warranty_attributes(object)
      end
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:country)
    end
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_warranties_path)
  end

  collection_action :fetch_combo_warranties, method: :get do
    data = Warranty.combo_warranties(params[:country_id])
    render json: data
  end

  filter :country
  filter :name
  filter :status, ActiveAdminCommon.filter_enum_attributes(Warranty.statuses)
  filter :plan, ActiveAdminCommon.filter_enum_attributes(Warranty.plans)

  actions :all, except: :destroy
end
