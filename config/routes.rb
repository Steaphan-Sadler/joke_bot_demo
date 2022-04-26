Rails.application.routes.draw do
  root 'robot#index'

  get 'robot/index', to: "robot#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
