Rails.application.routes.draw do

  root to: 'pages#index'
  
  resources :pages
  mount Ckeditor::Engine => '/ckeditor'
  resources :galleries
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
