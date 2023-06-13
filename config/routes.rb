Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  # resources :animes
  # resources :seasons

  resources :users, only: [:show, :edit, :update, :destroy]
  resources :animes do
    resources :reviews, only: [:create]
    resources :seasons, only: [:show] do
      resources :episodes, only: [:show, :index]
      resources :watchlists, only: [:create]
    end
  end
end
