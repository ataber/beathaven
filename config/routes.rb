Beathaven::Application.routes.draw do
  devise_for :users

  resources :performers, except: :destroy do
    resource :recipient, only: [:show, :create]
    resources :bookings, only: [:index, :create] do
      member do
        get :accept
        get :decline
      end
    end
  end

  resources :users do
    get :upcoming_events
    get :past_events
    get :performers
  end

  resources :comments
  resources :reviews

  root 'pages#home'
end
