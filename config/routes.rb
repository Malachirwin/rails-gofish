Rails.application.routes.draw do
  resources :games do
    member do
      post :leave
      post :run_round
      post :start_game_now
    end
  end
  root 'sessions#new'
  post 'sessions/create'
end
