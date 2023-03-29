Rails.application.routes.draw do
  get 'main/home'
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#home"


  resources :projects
  resources :bugs

  get '/populate_list', to: 'bugs#populate_list'
  # get '/projects', to: 'projects#index'
  # get '/project/new', to: 'projects#new'
  # post '/projects', to: 'projects#create'
  # get '/projects', to: 'projects#show'


  # get 'sign_in', to: 'devise/sessions#new'
  # get 'sign_up', to: 'devise/registrations#create'
  # get 'sign_out', to: 'devise/sessions#destroy'

end
