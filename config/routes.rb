Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'search#index'

  get '/search', to: 'search#index'
  get '/movie', to: 'search#movie'
end
