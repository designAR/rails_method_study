Rails.application.routes.draw do
  get 'sessions/create'
  get 'sessions/destroy'
  # main
  root "pages#home"

  get 'users', to: 'users#index'
  get 'users/:id', to: 'users#user_show', as: 'user'

  get 'user_search', to: 'users#user_search', as: 'user_search'

  # 회원가입
  get 'signup', to: 'users#new', as: 'signup'
  post 'users', to: 'users#create'

  # 회원삭제
  delete 'users/:id', to: 'users#destroy'

  # 회원수정
  get 'users/:id/edit', to: 'users#edit', as: 'edit_user'
  patch 'users/:id', to: 'users#update', as: 'update_user'

  # 로그인
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'

  # 로그아웃
  delete 'logout', to: 'sessions#destroy'
  get 'logout', to: 'sessions#destroy'

end