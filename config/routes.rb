Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#user_show', as: 'user'

  get 'user_search', to: 'users#user_search', as: 'user_search'

end