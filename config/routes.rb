Rails.application.routes.draw do
  devise_for :users
  get 'user_profile', to: 'pages#show'
  root 'pages#index'
  # For details on the DSL available within this file,
  # see https://guides.rubyonrails.org/routing.html
  resources :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
end
