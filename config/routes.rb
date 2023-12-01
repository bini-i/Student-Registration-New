Rails.application.routes.draw do
  resources :departments
  root 'pages#home'      #root path or home page
  devise_for :users

  resources :admin, only: [:index, :new, :create, :edit, :update, :destroy]
  post 'admin/:id/reset', to: "admin#reset", as: 'admin_reset'

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

  resources :students
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "students#index"
end
