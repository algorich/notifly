Notifly::Engine.routes.draw do
  resources :notifications, only: [:index] do
    post :read
    collection do
      get :count
    end
  end
end
