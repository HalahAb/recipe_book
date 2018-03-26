Rails.application.routes.draw do
  get 'welcome/index'
  get '/login' => 'sessions#new', as: "login"
  post '/login' => 'sessions#create'
  get '/logout' => 'sessions#destroy', as: "logout"

  get '/signup' => 'users#new', as: "signup"
  post '/users' => 'users#create'

  root "recipes#index"
  resources :recipes do
    get :list_unverified, on: :collection
    post :search, on: :collection
    put :verify, on: :member
    put :unverify, on: :member
    resources :comments, only: [:create, :destroy]
  end
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
