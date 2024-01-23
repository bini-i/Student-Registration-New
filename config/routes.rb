Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'pages#home'      #root path or home page
  devise_for :users
  
  # nested route for departments and courses
  resources :departments do
    resources :courses
    resources :students
    resources :searches, only: [ :new, :create, :show ]
    resources :registrations
  end

  get 'searches', to: "searches#index", as: 'searches'

  # a route to course destroy form action
  delete 'departments/:department_id/delete_course/:id', to: 'courses#destroy_form', as: 'course_destroy_form'

  # a route for admin controllers
  resources :admin, only: [:index, :new, :create, :edit, :update, :destroy]
  post 'admin/:id/reset', to: "admin#reset", as: 'admin_reset'

  as :user do
    get 'users/edit' => 'devise/registrations#edit', :as => 'edit_user_registration'    
    patch 'users' => 'devise/registrations#update', :as => 'user_registration'            
  end

  # custom dynamic route for students of a given year
  get 'departments/:department_id/students/class_year/:class_year', to: 'students#index', as: 'class_year_students'

  get 'departments/:department_id/students/year/:year', to: 'students#index', as: 'year_students'

  # custom dynamic route for students of a given section
  get 'departments/:department_id/students/year/:year/section/:section', to: 'students#index', as: 'section_students'
  
  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
end
