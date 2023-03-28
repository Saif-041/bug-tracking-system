Rails.application.routes.draw do
  get 'main/home'
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "main#home"
  # get 'sign_in', to: 'devise/sessions#new'
  # get 'sign_up', to: 'devise/registrations#create'
  # get 'sign_out', to: 'devise/sessions#destroy'

end
