Beathaven::Application.routes.draw do
  devise_for :users
  resources :performers do
    resources :bookings
  end
  resources :users
  root 'pages#home'
end
