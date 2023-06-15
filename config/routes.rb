Rails.application.routes.draw do
  get '/search', to: 'search#index', as: 'search'
  devise_for :users
  root to: "pages#home"

  resources :users

  resources :animes do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :episodes, only: [:show, :index]
    resources :watchlists, only: [:create]
  end

end
