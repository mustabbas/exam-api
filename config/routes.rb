Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get "/test", to: "test#index", as: "all_test"
      delete '/test/:id/destroy', to: 'test#destroy'
      post '/test/create', to: 'test#create', as: "test_create"
      get '/test/:id/edit', to: 'test#edit'
      put '/test/:id', to: 'test#update'

      post '/signup', to: 'users#create'
      get "/users", to: "users#index"
      get '/user/:id/edit', to: 'users#edit'
      put '/user/:id', to: 'users#update'
      delete '/user/:id/destroy', to: 'users#destroy'

      post 'auth/login', to: 'authentication#authenticate'

      get "/student/test", to: "test_student#index"
      get '/student/test/:id', to: 'test_student#show'
      post "/student/solution", to: "test_student#solution"
    end
  end
end
