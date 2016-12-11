Rails.application.routes.draw do
  devise_for :users
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :conversations, only: [:index, :new, :create] do
    resources :messages, only: [:index, :create] do
      post :mark_read, on: :member
    end
  end
  
  resources :users, only: [] do
    get :autocomplete_user_email, on: :collection
  end
  
  root to: 'default#show'
end
