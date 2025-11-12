module Admin
  class DashboardController < BaseController
    def index
      add_breadcrumb "ダッシュボード"

      # サンプルデータ
      @stats = {
        active_projects: 45,
        active_staff: 128,
        pending_invoices: 12,
        monthly_revenue: 15_500_000
      }

      @recent_projects = [
        { name: "システム開発案件A", client: "株式会社サンプル", status: "進行中", staff_count: 5 },
        { name: "ヘルプデスク業務", client: "○○商事", status: "募集中", staff_count: 3 },
        { name: "データ入力業務", client: "△△株式会社", status: "進行中", staff_count: 8 }
      ]

      @alerts = [
        { type: "warning", message: "3件の請求書が承認待ちです", time: "30分前" },
        { type: "info", message: "新規スタッフ登録が2件あります", time: "1時間前" },
        { type: "success", message: "案件Aの契約が完了しました", time: "2時間前" }
      ]
    end
  end
end
