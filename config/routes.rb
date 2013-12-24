Beathaven::Application.routes.draw do
  devise_for :users
  get "signin" => 'welcome#signin'
  root 'welcome#index'
end
