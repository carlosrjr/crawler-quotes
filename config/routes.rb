Rails.application.routes.draw do
  
  get "/quotes", to: "quotes#index"
  get "/quotes/:tag", to: "quotes#search"
  delete "/clean/quotes", to: "quotes#clean"
  
  get "/tags", to: "tags#show"
  get "/tags/:tag", to: "tags#search"
  delete "/tags/:tag", to: "tags#remove"
  delete "/clean/tags", to: "tags#clean"

  post "/auth/signin", to: "auths#signin"
  post "/auth/signup", to: "auths#signup"
  delete "/auth/remove", to: "auths#remove"

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
