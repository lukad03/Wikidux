Rails.application.routes.draw do

  get 'categories/index'

  get 'categories/show'

  get 'categories/new'

  get 'categories/create'

  get 'categories/edit'

  get 'categories/destroy'

  devise_for :users
  resources :articles
  root 'welcome#index'

end
