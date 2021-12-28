Rails.application.routes.draw do
  devise_for :users
  resources :rooms
  root 'rooms#index'
  patch 'rooms/:id/edit-score', to: 'scores#update', as: :edit_score
  post 'rooms/:id/', to: 'participants#create'
  get 'rooms/:id/create-participant', to: 'participants#new', as: :create_participant
  get 'rooms/:id/table', to: 'rooms#table', as: :table
  get 'rooms/:id/admins', to: 'admins#index', as: :admins
  delete 'rooms/:id/admins/:admin_id', to: 'admins#destroy', as: :admin
  post 'rooms/:id/admins', to: 'admins#create'
  get 'rooms/:id/admins/create', to: 'admins#new', as: :create_admin
  patch 'rooms/:id/admins/:admin_id', to: 'admins#update'
  get 'rooms/:id/admins/:admin_id/edit', to: 'admins#edit', as: :edit_admin
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
