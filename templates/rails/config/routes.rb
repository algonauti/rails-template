Rails.application.routes.draw do
  #
  # Web Authentication
  #
  devise_for :users

  #
  # API Authentication
  #
  use_doorkeeper

  #
  # API
  #
  namespace :api, defaults: { format: "jsonapi" } do
    scope module: :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
