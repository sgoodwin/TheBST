Rails.application.routes.draw do
  resources :users
  resources :listings, except: [:destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "listings#index"
  get "search", to: "listings#search", as: "search"
  post "markd/:id", to: "listings#mark", as: "mark"

  post "login", to: "users#login"
  get "logout", to: "users#logout", as: "logout"
  post "ban/:id", to: "users#ban", as: "ban"
end
