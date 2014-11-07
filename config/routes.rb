Notifly::Engine.routes.draw do
  resources :notifications do
    collection do
      get :count
    end
  end
end
