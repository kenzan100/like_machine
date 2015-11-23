Rails.application.routes.draw do
  root to: 'articles#index'
  get 'auth/:provider/callback', to: 'sessions#create', as: 'twitter_login'
  get 'submit', to: 'articles#new', as: 'submit'
  get 'signout', to: 'sessions#destroy', as: 'signout'
  get 'like_article', to: 'articles#like', as: 'like_article'

  resources :articles
end
