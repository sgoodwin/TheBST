Rails.application.routes.draw do
  resources :conversations, only: [:index, :show, :create]
  resources :users
  resources :listings, except: [:destroy]

  root "listings#index"
  get "search", to: "listings#search", as: "search"
  post "markd/:id", to: "listings#mark", as: "mark"

  post "message/:id", to: "conversations#new_message", as: "new_message"

  post "login", to: "users#login"
  get "logout", to: "users#logout", as: "logout"
  post "ban/:id", to: "users#ban", as: "ban"
end
