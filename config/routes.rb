Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  post 'weather', to: 'weather_data#create'
  get 'weather/:id', to: 'weather_data#show'
  get 'weather', to: 'weather_data#index'
end
