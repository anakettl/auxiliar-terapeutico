Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "patients#index"

  resources :patients do
    resources :trainings
  end
  resources :exercises
end
