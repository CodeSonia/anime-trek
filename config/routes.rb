Rails.application.routes.draw do
  get '/search', to: 'search#index', as: 'search'
  devise_for :users

  resources :users

    get '/users/:id', to: 'users#show'

  root to: "pages#home"

  resources :animes do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :episodes, only: [:show, :index] do
      resources :comments, only: [:new, :create, :destroy]
    end
    resources :watchlists, only: [:create]
  end

end
