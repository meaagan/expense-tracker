Rails.application.routes.draw do
  devise_for :users
  resources :transactions
  resources :budgets

  root "home#index"
end
