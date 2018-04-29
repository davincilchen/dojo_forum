Rails.application.routes.draw do
  #devise_for :users #original route for devise
  devise_for :users, :controllers => { :registrations => "users/registrations" }#20180421-01 add for devise because of strong parameter

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update] do

  end

  resources :dojos do
    resources :comments

    member do
      post :collect
      post :uncollect
    end
  end

  resources :friendships, only: :create do
    member do
      post   :accept
      delete :ignore
    end
  end

  resources :feeds, only: :index

  root "dojos#index"

  namespace :admin do
    resources :categories
    resources :users, only: [:index, :update]
    root "categories#index"
  end

end
