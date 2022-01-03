Rails.application.routes.draw do
  resources :users
  resources :listings
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "listings#index"

  post "login", to: "users#login"
end
