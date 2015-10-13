Rails.application.routes.draw do

  root 'cocktails#index'
  resources :cocktails do
    get :autocomplete_ingredient_name, on: :collection
  end
  resources :cocktails, only: [:index, :show]
  resources :ingredients, only: [:index, :show] 
end