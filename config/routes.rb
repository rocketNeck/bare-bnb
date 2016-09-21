Rails.application.routes.draw do
  get 'pages/home'

  devise_for :users

  
end
