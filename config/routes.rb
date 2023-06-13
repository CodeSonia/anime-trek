Rails.application.routes.draw do
  get 'episodes/index'
  get 'episodes/show'
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :animes do
    resources :reviews, only: [:create]
    resources :seasons do
      resources :episodes
      
  # resources :animes
  # resources :seasons

  resources :animes do
    resources :reviews, only: [:create]
    resources :seasons, only: [:show] do
      resources :episodes, only: [:show]

    end
  end
end
