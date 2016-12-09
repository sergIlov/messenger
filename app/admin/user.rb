ActiveAdmin.register User do
  config.batch_actions = false
  
  filter :email
  filter :created_at
  filter :last_sign_in_at
  filter :current_sign_in_at
  
  index download_links: false do
    column :email
    column :created_at
    column :last_sign_in_at
    column :current_sign_in_at
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
    end
  end
  
  form do |f|
    inputs do
      input :email
      input :password
      input :password_confirmation
    end
    actions
  end
  
  controller do
    def permitted_params
      params.permit(user: [:email, :password, :password_confirmation])
    end
  end
  
end