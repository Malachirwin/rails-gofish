Rails.application.routes.draw do
  resources :games do
    member do
      post :leave
    end
  end
  root 'sessions#new'
  post 'sessions/create'
end
