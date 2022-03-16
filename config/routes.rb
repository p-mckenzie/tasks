Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }
  root to: 'home#index'
  resources :groups
  resources :users, only: [:edit]
  match '/join_group' => 'groups#add', via: [:get, :post]
end
