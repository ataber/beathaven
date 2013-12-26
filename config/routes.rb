Beathaven::Application.routes.draw do
  resources :performers
  resources :users
  devise_for :users
  root 'pages#home'
end
