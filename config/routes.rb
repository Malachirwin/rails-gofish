Rails.application.routes.draw do
  resources :games
  root 'sessions#new'
  post 'sessions/create'
end
