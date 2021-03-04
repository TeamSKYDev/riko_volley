Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/callback" => "linebot#callback"
  root "posts#index"

  resources :notifications, only: [:update]
  resources :posts, only: %i[index create destroy]

  resources :places, only: [:create, :edit, :update, :destroy] do
    collection do
      patch :sort
    end

  end
end
