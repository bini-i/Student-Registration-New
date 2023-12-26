Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'pages#home'      #root path or home page
  devise_for :users
  
  # nested route for departments and courses
  resources :departments do
    resources :courses
  end

  # a route to course destroy form action
  delete 'departments/:department_id/delete_course/:id', to: 'courses#destroy_form', as: 'course_destroy_form'

  # a route for admin controllers
  resources :admin, only: [:index, :new, :create, :edit, :update, :destroy]
  post 'admin/:id/reset', to: "admin#reset", as: 'admin_reset'

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

  resources :students
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
