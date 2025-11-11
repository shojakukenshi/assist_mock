Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  root "admin/dashboard#index"

  namespace :admin do
    get "dashboard", to: "dashboard#index"

    # クライアント管理
    resources :clients

    # 案件管理
    resources :projects

    # 営業部門
    namespace :sales do
      resources :progress
      resources :expenses
      resources :invoices
      resources :reports
    end

    # 手配部門
    namespace :staffing do
      resources :recruitments
      resources :staff
      resources :assignments
      resources :attendances
      resources :support
      resources :compliance
    end

    # 経理部門
    namespace :accounting do
      resources :payrolls
      resources :insurance
      resources :expenses
      resources :receivables
      resources :financials
      resources :reports
    end

    # システム設定
    namespace :settings do
      resources :employees
      resources :masters
      resources :batch_processes
      get "profile", to: "profile#show"
    end
  end
end
