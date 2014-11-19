Notifly::Engine.routes.draw do
  resources :notifications, only: [:index] do
    put :read

    collection do
      get :counter
      put :update_counter
      put :read_specific
    end
  end
end
