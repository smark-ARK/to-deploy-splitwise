Rails.application.routes.draw do
  resources :payments
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :users, only: [:show] do
    member do
      post 'add_friend'
      delete 'remove_friend'
    end
  end
  
  root to: "static#dashboard"
  get 'people/:id', to: 'static#person'
  resources :expense, only: [:create]

end
