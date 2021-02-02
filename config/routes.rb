Rails.application.routes.draw do
  scope "(:locale)", locale: /en|zh-TW/ do
    resources :projects
  end
  root 'projects#index'
end
