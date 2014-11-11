Rails.application.routes.draw do
  mount Notifly::Engine => '/notifly', as: 'notifly'

  root to: 'site#index'
end
