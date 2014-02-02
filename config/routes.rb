Beathaven::Application.routes.draw do
  devise_for :users
  resources :performers do
    resources :bookings do
      member do
        get :accept
      end
    end
  end
  resources :users
  resources :comments
  root 'pages#home'
end
