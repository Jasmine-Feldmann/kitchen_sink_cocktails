Rails.application.routes.draw do

  root 'cocktails#index'
  resources :cocktails, only: [:index, :show]
  resources :ingredients, only: [:index, :show]

end