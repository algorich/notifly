Notifly::Engine.routes.draw do
  put '/notifications/(:notification_id)/toggle_read', to: 'notifications#toggle_read', as: :notification_toggle_read

  resources :notifications, only: [:index] do
    collection do
      put :read
      put :seen
    end
  end
end
