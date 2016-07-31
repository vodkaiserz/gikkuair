Rails.application.routes.draw do

  
  root 'home#index'

  get 'performer' => 'performer#index'
  mount Monologue::Engine, at: '/blog'

  devise_for 	:users,
  				path: "",
  				path_names: { sign_in: "login", sign_out: "logout", edit: "profile" },
  				controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end
  resources :users, only: [:show]
  
  resources :photos
  resources :proposals, only: [:new, :create]

  resources :profiles do
    resources :proposals, only: [:new, :create]
  end
  
  resources :videos
  get '/search' => 'pages#search'

end
