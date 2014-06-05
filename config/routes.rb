Beathaven::Application.routes.draw do
  devise_for :users

  resources :performers, except: :destroy do
    member do
      get :billing
      post :billing, to: "performers#update_billing"
    end
    resources :bookings, only: [:index, :create] do
      member do
        get :accept
        get :decline
      end
    end
  end
  resources :users
  resources :comments
  resources :reviews

  root 'pages#home'
end
