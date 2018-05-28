Rails.application.routes.draw do
  get '/login', to: 'session#new'

  get '/signup', to: 'users#new'

  post 'session/create'

  get '/logout', to: 'session#destroy'

  get '/auth/google_oauth2/callback', to: 'session#create'

  resources :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :students, only: [:index, :show]
  resources :standards, only: [:index, :show]

  resource :user do 
  	resource :comments
  end

  root 'users#show'
end
