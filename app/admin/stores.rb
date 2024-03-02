ActiveAdmin.register Store do
  permit_params :name, :country_id, :category_id, :status

  index do
    selectable_column
    column :country
    column :category
    column :name
    column('Status') { |country| status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red') }
    actions
  end

  show title: 'Show Store' do
    attributes_table do
      row :country
      row :category
      row :name
      row :status do |country|
        status_tag(country.active? ? 'Active' : 'Inactive', class: country.active? ? 'green' : 'red')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :country, include_blank: 'Select Country'
      f.input :category, get_category(object)
      f.input :name
      f.input :status, include_blank: false
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:country, :category)
    end
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_stores_path)
  end

  filter :name
  filter :country
  filter :category_name_cont, ActiveAdminCommon.filter_category
  filter :status, ActiveAdminCommon.filter_enum_attributes(Store.statuses)

  actions :all, except: :destroy
end
