Rails.application.routes.draw do
  devise_for :users, skip: :all
  devise_scope :user do
    get "login" => "users/sessions#new", as: :new_user_session
    post "login" => "users/sessions#create", as: :user_session
    delete "logout" => "users/sessions#destroy", as: :destroy_user_session
    get "accounts/edit" => "users/registrations#edit", as: :edit_user_registration
    put "users" => "users/registrations#update", as: :user_registration
  end


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
