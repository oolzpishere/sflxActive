Rails.application.routes.draw do

  get '/searches', to: 'searches#index'

  root to: 'pages#index'
#  get 'contact', to: 'pages#contact'
  get '/pages/:id', to: 'pages#show', as: 'page'
  get '/gallery_types/:id', to: 'gallery_types#show', as: 'gallery_type'
  

  # resources :pages
  mount Ckeditor::Engine => '/ckeditor'
  resources :galleries
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get '*path', to: 'pages#show'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
