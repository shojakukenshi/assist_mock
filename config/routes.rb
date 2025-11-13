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
    resources :projects do
      member do
        get :staff_matching      # スタッフマッチング画面
        post :send_recruitment   # 募集メール送信
      end
      resources :applications, only: [:index, :show] do
        member do
          post :accept  # 配置確定
          post :reject  # お断り
        end
      end
    end

    # 営業部門
    namespace :sales do
      get "pipeline", to: "pipeline#index"
      resources :expenses
      resources :billings
      get "analytics", to: "analytics#index"
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
      resources :payrolls do
        member do
          get :wizard_step1           # ステップ1: 給与計算
          post :execute_step1
          get :wizard_step2           # ステップ2: 給与明細発行
          post :execute_step2
          get :wizard_step3           # ステップ3: 給与振込
          post :execute_step3
          get :wizard_step4           # ステップ4: 完了
        end
      end

      # 社会保険・税務管理（期間別処理）
      resources :insurance do
        member do
          # 社会保険料計算フロー
          get :social_insurance_step1
          post :execute_social_insurance_step1
          get :social_insurance_step2
          post :execute_social_insurance_step2
          get :social_insurance_step3
          post :execute_social_insurance_step3
          get :social_insurance_step4
          post :execute_social_insurance_step4
          get :social_insurance_step5
          post :execute_social_insurance_step5
          get :social_insurance_step6

          # 源泉徴収処理フロー
          get :withholding_tax_step1
          post :execute_withholding_tax_step1
          get :withholding_tax_step2
          post :execute_withholding_tax_step2
          get :withholding_tax_step3
          post :execute_withholding_tax_step3
          get :withholding_tax_step4
          post :execute_withholding_tax_step4
          get :withholding_tax_step5
          post :execute_withholding_tax_step5
          get :withholding_tax_step6
        end
      end

      resources :expenses
      resources :receivables
      resources :financials
      resources :reports
    end

    # システム設定
    namespace :settings do
      # 社員管理
      resources :employees

      # マスタ管理
      resources :masters, only: [:index] do
        collection do
          get :belongings           # 持ち物マスター
          get :appearance           # 身だしなみマスター
          get :ip_addresses         # アクセスIPアドレス
          get :notification_emails  # 案件応募通知メールアドレスマスター
          get :salary_tables        # 支払い給与表
          get :mynumber_purposes    # マイナンバー利用目的マスター
        end
      end

      # バッチ・集計管理
      resources :batches, only: [:index] do
        collection do
          get :bulk_add_remarks           # スタッフ備考欄一括追加入力
          post :execute_bulk_add_remarks
          get :bulk_temporary_delete      # スタッフ一括一時削除
          post :execute_bulk_delete
          get :bulk_change_assignee       # スタッフの担当者を一括変更
          post :execute_bulk_change_assignee
          get :calculate_registration_ratio   # 登録者数・稼働数の比率算出
          get :calculate_rotation_rate        # 稼働単価・回転率・在庫回転率
        end
      end

      # マイページ
      get "mypage", to: "mypage#index"
      get "mypage/analytics", to: "mypage/analytics#index"
      get "mypage/messages", to: "mypage/messages#index"
      get "mypage/edit_message", to: "mypage/messages#edit_message"
      post "mypage/update_message", to: "mypage/messages#update_message"
    end
  end
end
