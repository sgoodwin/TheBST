Rails.application.routes.draw do
  resources :users
  resources :listings, except: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "listings#index"
  get "search", to: "listings#search", as: "search"
  post "mark_as_sold/:id", to: "listings#sold", as: "mark_as_sold"
  post "mark_as_cancelled/:id", to: "listings#cancel", as: "mark_as_cancel"

  post "login", to: "users#login"
  get "logout", to: "users#logout", as: "logout"
end
