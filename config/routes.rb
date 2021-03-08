Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post "/callback" => "linebot#callback"
  root "posts#index"

  resources :notifications, only: [:update]
  resources :posts, only: %i[index create destroy edit update]

  resources :places, only: [:create, :destroy] do
    collection do
      patch :sort
    end
  end

  resources :users, only: [:index, :create, :edit, :destroy]
end
