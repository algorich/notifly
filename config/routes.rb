Notifly::Engine.routes.draw do
  resources :notifications, only: [:index] do
    put :toggle_read

    collection do
      put :read
      put :seen
    end
  end
end
