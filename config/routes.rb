Rails.application.routes.draw do
  root to: 'articles#index'
  get 'auth/:provider/callback', to: 'sessions#create', as: 'twitter_login'
  get 'submit', to: 'articles#new', as: 'submit'
  get 'signout', to: 'sessions#destroy', as: 'signout'
end
