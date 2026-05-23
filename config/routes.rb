Rails.application.routes.draw do
  devise_for :users
  resources :expenses
  resources :budgets

  root "home#index"
end
