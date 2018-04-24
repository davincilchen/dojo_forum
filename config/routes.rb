Rails.application.routes.draw do
  #devise_for :users #original route for devise
  devise_for :users, :controllers => { :registrations => "users/registrations" }#20180421-01 add for devise because of strong parameter

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :users, only: [:show, :edit, :update] do

  end

  resources :dojos do
    resources :comments
  end

  root "dojos#index"
end
