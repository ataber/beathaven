Beathaven::Application.routes.draw do
  resources :performers

  devise_for :users
  root 'pages#home'
end
