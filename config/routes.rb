Rails.application.routes.draw do


  get 'reservations/:id/payment/new'=> "payment#new", as: 'payment_new'
  post 'reservations/:id/payment/checkout'=> "payment#checkout", as: 'payment_checkout'

  # get 'reservations/index'
  # get 'reservations/new'
  # get 'reservations/create'
  # get 'reservations/show'
  # get 'reservations/edit'
  # get 'reservations/update'
  # get 'reservations/destroy'
  # get 'listings/index'
  # get 'listings/new'
  # get 'listings/create'
  # get 'listings/show'
  # get 'listings/edit'
  # get 'listings/update'
  # get 'listings/destroy'




    get 'welcome/index'
  	root 'welcome#index'
    get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  # nest reservation routes into listings only new create index
  resources :listings do
    resources :reservations, only: [:new, :create, :index]
  end

  resources :reservations, except: [:new, :create, :index]

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "users", only: [:create] do

    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

    get "/sign_in" => "clearance/sessions#new", as: "sign_in"
    delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
    get "/sign_up" => "clearance/users#new", as: "sign_up"
    # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html



end
