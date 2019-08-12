Rails.application.routes.draw do
  #devise_for :users
  # ROTAS API
  namespace :api, defaults: { format: :json } do
    mount_devise_token_auth_for 'User', at: 'auth'
    
    namespace :v1 do
      resources :tasks

    end
  
  end
  
end