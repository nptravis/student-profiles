Rails.application.routes.draw do
  get '/login', to: 'session#new'

  get '/signup', to: 'users#new'

  post 'session/create'

  get '/logout', to: 'session#destroy'

  get '/auth/google_oauth2/callback', to: 'session#create'
  get '/courses', to: 'courses#index'


  resources :users
  resources :students do 
  	resources :comments
    resources :grades
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :students, only: [:index, :show, :new]
  resources :standards, only: [:index, :show]


  root 'session#index'
end
