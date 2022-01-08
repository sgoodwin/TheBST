Rails.application.routes.draw do
  resources :users
  resources :listings, except: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "listings#index"
  get "search", to: "listings#search", as: "search"
  post "mark_as_sold/:id", to: "listings#sold", as: "mark_as_sold"
  post "mark_as_cancelled/:id", to: "listings#cancel", as: "mark_as_cancel"
  post "mark_as_active/:id", to: "listings#active", as: "mark_as_active"

  post "login", to: "users#login"
end
