Rails.application.routes.draw do
  get "first_page" => 'home#index'

  get "logout" => "session#logout"

  resources :users
  resources :roles
  resources :resources
end
