Rails.application.routes.draw do
  get '/search', to: 'search#index', as: 'search'
  devise_for :users

  resources :users

    get '/users/:id', to: 'users#show'


  root to: "pages#home"

  resources :animes do
    resources :reviews, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :watchlists, only: [:create, :destroy]
  end
  resources :episodes, only: [:show, :index] do
    resources :comments, only: [:index, :new, :create]
  end

  resources :comments, only: [:destroy]
  # comment delete
end
