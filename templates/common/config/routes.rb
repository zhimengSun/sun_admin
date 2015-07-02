Rails.application.routes.draw do
  root 'home#index'

  get "logout" => "session#logout"
  get "login" => "session#login"
  post "login" => "session#login"

  resources :users
  resources :roles
  resources :resources
end
