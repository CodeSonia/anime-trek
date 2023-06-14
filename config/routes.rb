Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :users do
    resource :user_profile, only: [:show]
  end

  resources :animes do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :episodes, only: [:show, :index]
    resources :watchlists, only: [:create]
  end
end
