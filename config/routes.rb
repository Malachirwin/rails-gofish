Rails.application.routes.draw do
  # get 'session/new'
  resource :session
  get 'session/game'
  get 'session/create_game'
  get 'game/new'
  post 'game/create'
  root 'session#new'
  get    '/login',   to: 'session#new'
  post   '/login_post',   to: 'session#create'
  delete '/logout',  to: 'session#destroy'
  # patch 'user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
