Rails.application.routes.draw do
  root 'robot#index'

  get 'robot/index', to: 'robot#index'
  
  post 'joke/fetch' to:  'joke#fetch'
  
end
