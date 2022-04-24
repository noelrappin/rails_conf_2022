Rails.application.routes.draw do
  resources :cards
  resources :people
  resources :projects
  resources :card_order_changes, only: %w[update]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "projects#index"
end
