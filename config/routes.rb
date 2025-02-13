Rails.application.routes.draw do
  namespace :customer do
    get "products/index"
    get "products/show"
  end
  devise_for :admins, controllers: {
    sessions: "admin/sessions"
  }
  root to: "customer/products#index"
  devise_for :customers, controllers: {
    sessions: "customer/sessions",
    registrations: "customer/registrations"
  }
  namespace :admin do
    resources :products, only: %i[index show new create edit update]
  end
  scope module: :customer do
    resources :products, only: %i[index show]
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
end
