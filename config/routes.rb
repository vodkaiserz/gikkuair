Rails.application.routes.draw do

  resources :proposals, only: [:new, :create]
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

  resources :profiles, except: [:destroy] do
  	resources :bookings, only: [:create]
    resources :reviews, only: [:create, :destroy]
  end

  resources :bookings, only: [:create] do
    resource :feedback, only: [:create]
  end

  resources :conversations, only: [:index, :create] do
    resources :messages, only: [:index, :create]
  end

  
  get "/preload" => "bookings#preload"
  get "/preview" => "bookings#preview"
  get "/your_pastevents" => "bookings#your_pastevents"
  get "/your_bookings" => "bookings#your_bookings"

  post '/notify' => 'bookings#notify'
  post '/your_trips' => 'bookings#your_pastevents'

  get '/search' => 'pages#search'

end
