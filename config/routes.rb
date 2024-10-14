Rails.application.routes.draw do
  get 'users/new'
  get 'users/create'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "application/L4" => "application#L4"
 # root "application#L4"
  
  
  get 'top/main'
  post 'top/login'
  root 'top#main'
  get'top/logout'
  
  
  # 新規ユーザー登録のルート
  get 'users/new', to: 'users#new', as: 'new_user'
  post 'users', to: 'users#create'

end
