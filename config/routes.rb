Rails.application.routes.draw do
  resources :expenses
  root "expenses#index"
  get "expenses/new", to: "expenses#new"
  post "expenses", to: "expenses#create"
  get "expenses/:id/edit", to: "expenses#edit"
  patch "expenses/:id", to: "expenses#update"
  delete "expenses/:id", to: "expenses#destroy"

  resources :users, only: [:new, :create]
  get "signup", to: "users#new"
  post "signup", to: "users#create"
end
