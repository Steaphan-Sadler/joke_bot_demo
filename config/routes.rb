Rails.application.routes.draw do
  root 'robot#index'

  get 'robot/index', to: "robot#index"
  
  post 'joke/fetch' => "joke#fetch"
  
end
