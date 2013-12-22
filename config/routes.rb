Beathaven::Application.routes.draw do
  get "signin" => 'welcome#signin'
  root 'welcome#index'
end
