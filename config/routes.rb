Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # Defines the root path route ("/")
  root "posts#index"

  constraints(ClientDomainConstraint.new) do
    resources :posts do
      resources :comments, except: :show
    end
    resources :top_ups, only: [:new, :create]
  end
  resources :types

  constraints(AdminDomainConstraint.new) do
    namespace :admin do
      resources :users
      resources :posts
    end
  end
  get "/:unique_string", to: "posts#short_url"
  namespace :api do
    resources :regions, only: :index, defaults: { format: :json } do
      resources :provinces, only: :index, defaults: { format: :json } do
        resources :city_municipalities, only: :index, defaults: { format: :json } do
          resources :barangays, only: :index, defaults: { format: :json }
        end
      end
      resources :districts, only: :index, defaults: { format: :json } do
        resources :city_municipalities, only: :index, defaults: { format: :json } do
          resources :barangays, only: :index, defaults: { format: :json }
        end
      end
    end
  end
end
