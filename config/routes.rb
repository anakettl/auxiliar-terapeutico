Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "dashboard#index", as: :dashboard

  resources :patients do
    resources :trainings do
      resources :realizations
    end
  end
  resources :exercises

  get '/delete_session', to: 'users#delete_session'
end
