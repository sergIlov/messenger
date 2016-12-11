ActiveAdmin.register User do
  #config.batch_actions = false
  
  filter :email
  filter :created_at
  filter :last_sign_in_at
  filter :current_sign_in_at
  filter :is_blocked
  
  batch_action :block do |ids|
    User.where(id: ids).update_all(is_blocked: true)
    redirect_to collection_path, alert: 'Users blocked'
  end
  
  batch_action :unblock do |ids|
    User.where(id: ids).update_all(is_blocked: false)
    redirect_to collection_path, alert: 'Users unblocked'
  end
  
  index download_links: false do
    selectable_column
    column :email
    column :created_at
    column :last_sign_in_at
    column :current_sign_in_at
    column :is_blocked
    actions
  end
  
  show do
    attributes_table do
      row :id
      row :email
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
      row :created_at
      row :updated_at
      row :is_blocked
    end
  end
  
  form do |f|
    inputs do
      input :email
      input :password
      input :password_confirmation
      input :is_blocked
    end
    actions
  end
  
  controller do
    def permitted_params
      params.permit(user: [:email, :password, :password_confirmation, :is_blocked])
    end
    
    def update
      if params[:user][:password].blank?
        params[:user].delete(:password)
        params[:user].delete(:password_confirmation)
      end
      super
    end
  end
  
end