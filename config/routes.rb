Rails.application.routes.draw do
  resources :suggestions
  resources :teachers
  resources :sections
  get '/login', to: 'session#new'

  get '/signup', to: 'users#new'

  post 'session/create'

  get '/logout', to: 'session#destroy'

  get '/auth/google_oauth2/callback', to: 'session#create'

  get '/sections/:id/students', to: 'sections#students'

  get '/sections/:section_id/students/:id', to: 'students#show'

  get '/teachers/:id/students', to: 'teachers#students'

  get '/students/:id/schedule', to: 'students#schedule'

  get '/students/:id/bell_schedule', to: 'students#bell_schedule'
  get '/students/:id/map', to: 'students#map'
  get '/students/:id/sections', to: 'students#sections'
  get '/students/:id/sections/:section_id', to: 'students#section'
  post '/standards/:id/grades_per_term', to: 'standards#grades_per_term'
  get '/standards/:id/all_grades', to: 'standards#all_grades'
  get '/students/:id/reportcard', to: 'students#reportcard'

  resources :users do
    resources :courses
    resources :sections
  end

  resources :courses
  resources :terms
  
  resources :students do 
  	resources :comments
    resources :grades
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :students, only: [:index, :show, :new]
  resources :standards, only: [:index, :show]


  root 'session#index'
end
