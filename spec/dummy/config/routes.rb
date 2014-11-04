Rails.application.routes.draw do
  mount Notifly::Engine => "/notifly"

  root to: 'site#index'
end
