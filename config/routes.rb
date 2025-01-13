Rails.application.routes.draw do
  devise_for :users
  
  resources :files do
    member do
      post :generate_share_link
      delete :revoke_share_link
    end
  end
  
  get 's/:token', to: 'shared_files#show', as: :short_shared_file
  get '/shared/:token', to: 'shared_files#show', as: :shared_file
  root 'files#index'
  
  require 'sidekiq/web'
  authenticate :user do
    mount Sidekiq::Web => '/sidekiq'
  end

  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  
end