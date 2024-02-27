Rails.application.routes.draw do
  # Defines the root path route ("/")
  root 'pages#home'      #root path or home page
  devise_for :users
  
  # nested route for departments and courses
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
  
  # ***************custom routes for students*************
  
  # custom dynamic route for filtering students
  # get 'departments/:department_id/students/filter', to: 'students#filter', as: 'filter_students'

  # custom dynamic route for students of a given year
  get 'departments/:department_id/students/year/:year/class_year/:class_year', to: 'students#index', as: 'class_year_students'
  
  get 'departments/:department_id/students/year/:year', to: 'students#index', as: 'year_students'
  
  # custom dynamic route for students of a given section
  get 'departments/:department_id/students/year/:year/section/:section', to: 'students#index', as: 'section_students'

  # custom dynamic route for changing section of a student
  get 'departments/:department_id/section/student/:student_id', to: 'sections#change_section', as: 'change_section'
  
  post 'departments/:department_id/section/student/:student_id', to: 'sections#handle_section_change', as: 'handle_section_change'
  

  # ***************custom routes for registrations*************

  # custom dynamic route for registration academic year
  get 'departments/:department_id/registrations/academic_year/:academic_year', to: 'registrations#academic_year_registrations', as: 'academic_year_registrations'

  # custom dyanmic route for registration class year
  get 'departments/:department_id/registrations/academic_year/:academic_year/class_year/:class_year', to: 'registrations#class_year_registrations', as: 'class_year_registrations'
  
  # custom dynamic route for sections registered of a given class year and semester
  # get 'departments/:department_id/registrations/academic_year/:academic_year/class_year/:class_year/semester/:semester', to: 'registrations#registred_sections'

  # custom dynamic route for sections registered of a given class year and semester
  get 'departments/:department_id/registrations/academic_year/:academic_year/class_year/:class_year/semester/:semester', to: 'registrations#registered_students', as: 'registered_students'

  # resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  
  
  resources :departments do
    resources :courses
    resources :students
    resources :searches, only: [ :new, :create, :show ]
    resources :registrations
  
    get 'sections/index'
    get 'sections/change_section'
    get 'sections/handle_section_change'
  end
end

