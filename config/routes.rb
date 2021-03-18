Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-TW/ do
    root 'pages#home'

    resources :users, except: [:new] do
      resources :projects
    end

    scope path: 'projects/:project_id', as: :project do
      delete 'labels/remove/:id', to: 'labels#remove', as: :remove_label
    end

    get '/signup', to: 'users#new'
    get '/login', to: 'sessions#new'
    post '/login', to: 'sessions#create'
    delete '/logout', to: 'sessions#destroy'

    get '/404', to: 'errors#not_found', via: :all, as: 'error_not_found'
    get '/500', to: 'errors#internal_server_error', via: :all, as: 'error_server_error'

    namespace "admin" do
      root 'admin#index'
      resources :users
    end
  end

end
