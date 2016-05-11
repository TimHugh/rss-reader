Rails.application.routes.draw do
  root 'feed_items#index'

  resources :feeds, only: [:index, :new, :create]
  resources :feed_items, only: [:index, :show, :update]
end
