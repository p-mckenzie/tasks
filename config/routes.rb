Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  root to: 'home#index'

  resources :groups do
    resources :tasks
  end

  resources :users, only: [:edit]

  get '/join_group' => 'user_group_assignments#new'
  post '/join_group' => 'user_group_assignments#create'
  delete '/leave_group' => 'user_group_assignments#destroy'
end
