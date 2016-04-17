Rails.application.routes.draw do
  root 'feeds#index'

  resources :feeds, only: [:index, :new, :create]
  resources :feed_items, only: [:index, :show, :update]
end
