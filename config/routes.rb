Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about" => "homes#about", as: "about"
  patch 'users/:id' => 'users#update', as: 'update_user'
  
  resources :users
  resources :books

end
