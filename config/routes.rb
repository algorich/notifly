Notifly::Engine.routes.draw do
  resources :notifications, only: [:index] do
    collection do
      get :count
    end
  end
end
