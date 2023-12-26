Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#user_show', as: 'user'

  get 'user_search', to: 'users#user_search', as: 'user_search'

  # 회원가입
  get 'signup', to: 'users#new', as: 'signup'
  post 'users', to: 'users#create'

  # 회원삭제
  delete 'users/:id', to: 'users#destroy'
end