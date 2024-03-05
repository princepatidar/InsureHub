ActiveAdmin.register Item do
  permit_params :name, :depreciation_rate, :status, :country_id, :category_id, :is_renewable, warranty_ids: []

  index do
    column :country
    column :category
    column :name
    column('Status') { |item| status_tag(item.active? ? 'Active' : 'Inactive', class: item.active? ? 'green' : 'red') }
    actions
  end

  show do
    attributes_table do
      row :country
      row :category
      row :name
      row :is_renewable
      row :depreciation_rate
      row 'Status' do |item|
        status_tag(item.active? ? 'Active' : 'Inactive', class: item.active? ? 'green' : 'red')
      end
      row :warranties
    end
  end

  form do |f|
    f.inputs do
      f.input :country, country_attributes(object)
      f.input :category, get_category(object)
      f.input :name, item_attributes(object)
      f.input :status
      f.input :is_renewable
      f.input :depreciation_rate, label: 'Depreciation rate (in %)'
      f.input :warranties, warranties_attributes(object)
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.includes(:country, :category)
    end
  end

  collection_action :fetch_item_warranties, method: :get do
    result = Item.list_warranties(params[:country_id], params[:category_name])
    render json: result
  end

  action_item 'Back', only: :show do
    link_to('Back', admin_items_path)
  end

  filter :name
  filter :country
  filter :category_name_cont, ActiveAdminCommon.filter_category
  filter :status, ActiveAdminCommon.filter_enum_attributes(Item.statuses)

  actions :all, except: :destroy
end
