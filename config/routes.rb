Rails.application.routes.draw do
  get 'pages/home'

  devise_for :users

  root to: "home#index"
end
