Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"

  resources :animes do
    resources :reviews, only: [:new, :create, :edit, :update, :destroy]
    resources :seasons, only: [:show] do
      resources :episodes, only: [:show]
    end
  end
end
