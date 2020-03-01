Rails.application.routes.draw do
  
  root 'static_pages#top'
  get '/signup', to: 'users#new'
  
  get    '/login', to: 'sessions#new'
  post   '/login', to: 'sessions#create'
  
  get 'tasks/new', to: 'tasks#new'
  get 'tasks/index', to: 'tasks#index'
  get 'tasks/:id', to: 'tasks#show'

 
  delete '/logout', to: 'sessions#destroy'
  
  resources :users do
    member do
      resources :tasks
    end
  end
end
