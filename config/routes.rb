Beathaven::Application.routes.draw do
  devise_for :users
  resources :performers
  resources :users
  root 'pages#home'
end
