# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    resources :taxi_requests, path: '/taxi-requests', only: %i(index create)
    resources :users, only: :create
    put '/taxi-requests/:id/assign', to: 'taxi_requests#update'
    post '/users/signin', to: 'authentication#authenticate'
  end
end
