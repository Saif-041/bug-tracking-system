# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :projects do
    resources :bugs
  end

  root 'main#home'
  get 'main/home'
  get 'user/:id/bugs', to: 'bugs#user', as: 'user_bugs'
  get 'user/:id/features', to: 'bugs#feature', as: 'user_features'
end
