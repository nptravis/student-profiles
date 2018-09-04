Rails.application.routes.draw do
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

  resources :users do
    resources :courses
    resources :sections
  end
  
  resources :students do 
  	resources :comments
    resources :grades
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :students, only: [:index, :show, :new]
  resources :standards, only: [:index, :show]


  root 'session#index'
end
