Rails.application.routes.draw do
  devise_for :users
  get 'user_profile', to: 'pages#show'
  get 'users_list', to: 'users#index'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    get 'signup', to: 'devise/registrations#new'
  end

  root 'posts#index'
  # For details on the DSL available within this file,
  # see https://guides.rubyonrails.org/routing.html
  resources :posts do
    resources :comments
    resources :likes
  end

  resources :comments
  resources :users
end
