Rails.application.routes.draw do
  # get 'session/new'
  resource :session
  get 'sessions/index'
  get 'sessions/create_game'
  get 'game/new'
  get 'game/show'
  post 'game/create'
  root 'sessions#new'
  get    '/login',   to: 'sessions#new'
  post   '/login_post',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  # patch 'user'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
