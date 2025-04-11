Rails.application.routes.draw do
  devise_for :users
  root to: "homes#top"
  get "homes/about" => "homes#about", as: "about"
  patch 'users/:id' => 'users#update', as: 'update_user'
  get 'books/:id' => 'books#show', as: 'book'
  delete 'books/:id' => 'books#destroy', as: 'destroy_book'
  resources :users
  resources :books

end
