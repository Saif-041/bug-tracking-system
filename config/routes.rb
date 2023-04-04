Rails.application.routes.draw do
  get 'main/home'
  
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  root "main#home"

  resources :projects do
    resources :bugs
  end

  get 'user/:id/bugs', to: 'bugs#user', as: 'user_bugs'
  get 'user/:id/features', to: 'bugs#feature', as: 'user_features'


  # get '/projects', to: 'projects#index'
  # get '/project/new', to: 'projects#new'
  # post '/projects', to: 'projects#create'
  # get '/projects', to: 'projects#show'
  # get 'sign_in', to: 'devise/sessions#new'
  # get 'sign_up', to: 'devise/registrations#create'
  # get 'sign_out', to: 'devise/sessions#destroy'

end
