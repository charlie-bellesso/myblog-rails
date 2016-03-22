Rails.application.routes.draw do

  root 'pages#index'

  # posts routes
  resources :posts

  # sessions routes
  get '/login' => 'sessions#new'
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy'

  # users routes
  get '/signup' => 'users#new'
  post '/users/create' => 'users#create'

  # comments routes
  post '/comments/:id' => 'comments#create', as: 'post_comment'

  # redirect all unknown routes to root
  get '*path', to: redirect('/')
end
