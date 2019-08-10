Rails.application.routes.draw do
  get 'sessions/new'
  get 'sessions/crate'
  get 'sessions/destroy'
    root to: "tasks#index"
    resources :tasks

    get "login", to: "sessions#new"
    post "login", to: "sessions#create"
    delete "logout", to: "sessions#destroy"
    
    get "signup", to: "users#new"
    resources :users, only: [:index, :show, :new, :create]
end