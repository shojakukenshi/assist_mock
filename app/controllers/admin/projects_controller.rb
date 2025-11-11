module Admin
  class ProjectsController < BaseController
    def index
      add_breadcrumb "案件管理"

      @projects = [
        { id: 1, name: "システム開発案件A", client: "株式会社サンプル", status: "進行中", staff_count: 5, start_date: "2024-04-01", end_date: "2025-03-31" },
        { id: 2, name: "ヘルプデスク業務", client: "○○商事", status: "募集中", staff_count: 3, start_date: "2024-06-01", end_date: "2024-12-31" },
        { id: 3, name: "データ入力業務", client: "△△株式会社", status: "進行中", staff_count: 8, start_date: "2024-01-15", end_date: "2024-12-31" }
      ]
    end

    def show
      add_breadcrumb "案件管理", admin_projects_path
      add_breadcrumb "案件詳細"
    end

    def new
      add_breadcrumb "案件管理", admin_projects_path
      add_breadcrumb "新規登録"
    end

    def edit
      add_breadcrumb "案件管理", admin_projects_path
      add_breadcrumb "編集"
    end
  end
end
