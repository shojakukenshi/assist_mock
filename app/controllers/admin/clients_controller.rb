module Admin
  class ClientsController < BaseController
    def index
      add_breadcrumb "クライアント管理"

      # サンプルデータ
      @clients = [
        { id: 1, name: "株式会社サンプル", industry: "IT・通信", status: "稼働中", projects_count: 5, created_at: "2024-01-15" },
        { id: 2, name: "○○商事株式会社", industry: "商社", status: "稼働中", projects_count: 3, created_at: "2024-02-20" },
        { id: 3, name: "△△株式会社", industry: "製造業", status: "休止中", projects_count: 1, created_at: "2023-12-10" },
        { id: 4, name: "□□コーポレーション", industry: "金融", status: "稼働中", projects_count: 8, created_at: "2023-11-05" }
      ]
    end

    def show
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "クライアント詳細"
    end

    def new
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "新規登録"
    end

    def edit
      add_breadcrumb "クライアント管理", admin_clients_path
      add_breadcrumb "編集"
    end
  end
end
