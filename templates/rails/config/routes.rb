Rails.application.routes.draw do
  #
  #
  #
  use_doorkeeper

  #
  #
  #
  devise_for :users

  #
  # API
  #
  namespace :api, defaults: { format: "json" } do
    scope module: :v1 do
      resources :users, only: [:show]
    end
  end
  root to: "application#root"
end
