Rails.application.routes.draw do
  resources :games do
    member do
      post :leave
      post :run_round
      post :start_game_now
      post :update_level
    end
  end
  delete 'sessions/destroy'
  get 'leader_boards', to: 'games#leader_boards'
  root 'sessions#new'
  post 'sessions/create'
end
