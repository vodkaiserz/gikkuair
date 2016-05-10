Rails.application.routes.draw do

  
  root 'home#index'

  get 'pages' => 'pages#home'
  get 'performer' => 'performer#index'
  mount Monologue::Engine, at: '/blog'

  devise_for 	:users,
  				path: "",
  				path_names: { sign_in: "login", sign_out: "logout", edit: "profile" },
  				controllers: { omniauth_callbacks: "omniauth_callbacks", registrations: "registrations" }


  resources :users, only: [:show]
  
  resources :photos
  resources :proposals, only: [:new, :create]

  resources :profiles, except: [:destroy] do
    resources :proposals, only: [:new, :create]
  end
  
  get '/proposals' => 'proposals#new'

  get '/search' => 'pages#search'

end
