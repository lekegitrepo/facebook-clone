Rails.application.routes.draw do
  devise_for :users
  get 'user_profile', to: 'pages#show'
  get 'users_list', to: 'pages#all_users'
  root 'posts#index'
  # For details on the DSL available within this file,
  # see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users

  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end
end
