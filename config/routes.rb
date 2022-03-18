Rails.application.routes.draw do
  namespace :api do
    get '/reviews/search', to: 'reviews/search#index'

    resources :authors, only: [:create, :index, :show, :update]
    resources :books, only: [:create, :index, :show, :update] do
      get '/reviews', to: 'books/reviews#index'
    end
    resources :users, only: [:create, :index, :show, :update]
    resources :reviews, only: [:create, :index, :show, :update]

  end
end
