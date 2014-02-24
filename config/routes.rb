Beathaven::Application.routes.draw do
  devise_for :users

  resources :performers, except: :destroy do
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
