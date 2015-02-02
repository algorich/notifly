Rails.application.routes.draw do
  mount Notifly::Engine => '/notifly', as: 'notifly'

  post 'create', to: 'site#create_notification',  as: :create_notification
  root to: 'site#index'
end
