Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :users
  resources :user_profile, only: [:show, :edit, :update, :destroy]

  resources :animes do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :seasons, only: [:show] do

      resources :episodes, only: [:show, :index]
      resources :watchlists, only: [:create]

    end
  end
end
