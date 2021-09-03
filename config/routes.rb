Rails.application.routes.draw do
  #resources :quotes

  get '/quotes', to: "quotes#index"
  get '/quotes/:tag', to: "quotes#search"
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
