Rails.application.routes.draw do
  devise_for :users, :path => '', :path_names => { :sign_in => "login", :sign_out => "logout", :sign_up => "register" }

  root to: 'home#index'
  get '/my_tasks' => 'users#my_tasks'

  resources :groups do
    resources :tasks, except: [:index]
    put '/update_tasks/:id', to: 'tasks#complete_instance', as: :task_complete
    put '/claim_task/:id', to: 'tasks#claim', as: :task_claim
    put '/claim_all/:id', to: 'tasks#claim_all', as: :task_claim_all
  end


  resources :users, only: [:show]

  get '/join_group' => 'user_group_assignments#new'
  post '/join_group' => 'user_group_assignments#create'
  delete '/leave_group' => 'user_group_assignments#destroy'
end
