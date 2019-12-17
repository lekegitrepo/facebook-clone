Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'contact', to: 'pages#contact'
  get 'terms', to: 'pages#terms'
  get 'privacy', to: 'pages#privacy'
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

  resources :users do
    resources :friendships
    delete 'reject_request', to: 'friendships#destroy'
    post 'accept_request', to: 'friendships#update'
  end

  resources :comments
  resources :users
end
