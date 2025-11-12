class Admin::Settings::BatchesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path }
    ]

    # バッチ処理一覧
    @batch_processes = [
      {
        id: "bulk_add_remarks",
        name: "スタッフ備考欄一括追加入力",
        description: "複数のスタッフに対して備考を一括で追加",
        category: "スタッフ管理",
        last_executed: "2025-11-10 15:30",
        execution_count: 24,
        path: bulk_add_remarks_admin_settings_batches_path
      },
      {
        id: "bulk_temporary_delete",
        name: "スタッフ一括一時削除",
        description: "休眠スタッフを一時的に削除（復元可能）",
        category: "スタッフ管理",
        last_executed: "2025-11-01 10:00",
        execution_count: 8,
        path: bulk_temporary_delete_admin_settings_batches_path
      },
      {
        id: "bulk_change_assignee",
        name: "スタッフの担当者を一括変更",
        description: "スタッフの担当営業・手配担当を一括変更",
        category: "スタッフ管理",
        last_executed: "2025-10-15 14:20",
        execution_count: 12,
        path: bulk_change_assignee_admin_settings_batches_path
      },
      {
        id: "calculate_registration_ratio",
        name: "登録者数・稼働数の比率算出",
        description: "登録スタッフ数と実際の稼働数の比率を集計",
        category: "集計・分析",
        last_executed: "2025-11-12 09:00",
        execution_count: 156,
        path: calculate_registration_ratio_admin_settings_batches_path
      },
      {
        id: "calculate_rotation_rate",
        name: "稼働単価・回転率・在庫回転率",
        description: "スタッフの稼働効率と収益性の分析",
        category: "集計・分析",
        last_executed: "2025-11-12 09:30",
        execution_count: 142,
        path: calculate_rotation_rate_admin_settings_batches_path
      }
    ]

    # 実行履歴サマリー
    @execution_summary = {
      today: 2,
      this_week: 8,
      this_month: 35,
      total: 342
    }
  end

  # スタッフ備考欄一括追加入力
  def bulk_add_remarks
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path },
      { name: "スタッフ備考欄一括追加入力", path: bulk_add_remarks_admin_settings_batches_path }
    ]

    # スタッフ一覧（選択用）
    @staff_list = [
      { id: 1, code: "ST-0001", name: "山本太郎", current_remarks: "VIP対応可能、英語対応可" },
      { id: 2, code: "ST-0002", name: "鈴木花子", current_remarks: "ブライダル経験豊富" },
      { id: 3, code: "ST-0003", name: "田中一郎", current_remarks: "中国語通訳可能" },
      { id: 4, code: "ST-0004", name: "佐藤美咲", current_remarks: nil },
      { id: 5, code: "ST-0005", name: "高橋健太", current_remarks: "大型機材搬入経験あり" }
    ]

    # 備考テンプレート
    @remark_templates = [
      "12月繁忙期対応可能",
      "夜間・早朝勤務OK",
      "週末勤務優先",
      "長期案件希望",
      "短期単発のみ",
      "VIP対応経験あり",
      "英語対応可能",
      "フォークリフト免許保有",
      "普通救命講習修了"
    ]
  end

  def execute_bulk_add_remarks
    # 実際の処理はここに実装
    flash[:success] = "#{params[:staff_ids]&.count || 0}名のスタッフに備考を追加しました。"
    redirect_to bulk_add_remarks_admin_settings_batches_path
  end

  # スタッフ一括一時削除
  def bulk_temporary_delete
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path },
      { name: "スタッフ一括一時削除", path: bulk_temporary_delete_admin_settings_batches_path }
    ]

    # 休眠スタッフ（6ヶ月以上稼働なし）
    @inactive_staff = [
      { id: 15, code: "ST-0015", name: "林太郎", last_work_date: "2025-04-20", days_inactive: 205, total_projects: 8 },
      { id: 18, code: "ST-0018", name: "木村美咲", last_work_date: "2025-03-15", days_inactive: 241, total_projects: 5 },
      { id: 22, code: "ST-0022", name: "井上健", last_work_date: "2025-02-28", days_inactive: 256, total_projects: 12 },
      { id: 25, code: "ST-0025", name: "清水愛", last_work_date: "2025-01-15", days_inactive: 300, total_projects: 3 },
      { id: 28, code: "ST-0028", name: "斎藤誠", last_work_date: "2024-12-10", days_inactive: 336, total_projects: 15 }
    ]

    @summary = {
      total_inactive: 28,
      over_6_months: 15,
      over_1_year: 8,
      total_staff: 158
    }
  end

  def execute_bulk_delete
    # 実際の処理はここに実装
    flash[:success] = "#{params[:staff_ids]&.count || 0}名のスタッフを一時削除しました。"
    redirect_to bulk_temporary_delete_admin_settings_batches_path
  end

  # スタッフの担当者を一括変更
  def bulk_change_assignee
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path },
      { name: "スタッフの担当者を一括変更", path: bulk_change_assignee_admin_settings_batches_path }
    ]

    # 担当者リスト
    @assignees = [
      { id: 1, name: "佐藤花子", department: "営業部", current_staff_count: 45 },
      { id: 2, name: "田中次郎", department: "営業部", current_staff_count: 38 },
      { id: 3, name: "伊藤健太", department: "営業部", current_staff_count: 42 },
      { id: 4, name: "鈴木美咲", department: "営業部", current_staff_count: 33 },
      { id: 5, name: "高橋美穂", department: "手配部", current_staff_count: 52 },
      { id: 6, name: "渡辺翔太", department: "手配部", current_staff_count: 48 },
      { id: 7, name: "中村里奈", department: "手配部", current_staff_count: 28 }
    ]

    # 変更対象スタッフ（例：退職した担当者のスタッフ）
    @staff_to_reassign = [
      { id: 30, code: "ST-0030", name: "山田花子", current_assignee: "（未割当）", skills: "接客、英語" },
      { id: 31, code: "ST-0031", name: "佐々木太郎", current_assignee: "（未割当）", skills: "展示会経験" },
      { id: 32, code: "ST-0032", name: "田村美穂", current_assignee: "（未割当）", skills: "ブライダル" }
    ]
  end

  def execute_bulk_change_assignee
    # 実際の処理はここに実装
    flash[:success] = "#{params[:staff_ids]&.count || 0}名のスタッフの担当者を変更しました。"
    redirect_to bulk_change_assignee_admin_settings_batches_path
  end

  # 登録者数・稼働数の比率算出
  def calculate_registration_ratio
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path },
      { name: "登録者数・稼働数の比率算出", path: calculate_registration_ratio_admin_settings_batches_path }
    ]

    # 月別登録者数・稼働数
    @monthly_data = [
      {
        month: "2025-06",
        registered: 145,
        active: 128,
        ratio: 88.3,
        new_registrations: 8,
        churned: 3
      },
      {
        month: "2025-07",
        registered: 150,
        active: 132,
        ratio: 88.0,
        new_registrations: 10,
        churned: 5
      },
      {
        month: "2025-08",
        registered: 155,
        active: 135,
        ratio: 87.1,
        new_registrations: 12,
        churned: 7
      },
      {
        month: "2025-09",
        registered: 160,
        active: 140,
        ratio: 87.5,
        new_registrations: 9,
        churned: 4
      },
      {
        month: "2025-10",
        registered: 165,
        active: 145,
        ratio: 87.9,
        new_registrations: 11,
        churned: 6
      },
      {
        month: "2025-11",
        registered: 170,
        active: 150,
        ratio: 88.2,
        new_registrations: 13,
        churned: 8
      }
    ]

    # スキル別稼働率
    @skill_based_ratio = [
      { skill: "接客", registered: 85, active: 78, ratio: 91.8 },
      { skill: "英語", registered: 42, active: 38, ratio: 90.5 },
      { skill: "イベント経験", registered: 68, active: 58, ratio: 85.3 },
      { skill: "展示会経験", registered: 38, active: 32, ratio: 84.2 },
      { skill: "フォーマル対応", registered: 45, active: 40, ratio: 88.9 },
      { skill: "VIP対応", registered: 28, active: 25, ratio: 89.3 }
    ]

    # サマリー
    @summary = {
      current_registered: 170,
      current_active: 150,
      current_ratio: 88.2,
      avg_ratio_6months: 87.8,
      target_ratio: 90.0,
      gap: -1.8
    }
  end

  # 稼働単価・回転率・在庫回転率
  def calculate_rotation_rate
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_batches_path },
      { name: "バッチ・集計管理", path: admin_settings_batches_path },
      { name: "稼働単価・回転率・在庫回転率", path: calculate_rotation_rate_admin_settings_batches_path }
    ]

    # 月別稼働データ
    @monthly_rotation = [
      {
        month: "2025-06",
        total_staff: 145,
        active_staff: 128,
        total_revenue: 42_500_000,
        avg_unit_price: 3_100,
        rotation_rate: 2.8,
        inventory_turnover: 3.2
      },
      {
        month: "2025-07",
        total_staff: 150,
        active_staff: 132,
        total_revenue: 45_200_000,
        avg_unit_price: 3_150,
        rotation_rate: 2.9,
        inventory_turnover: 3.3
      },
      {
        month: "2025-08",
        total_staff: 155,
        active_staff: 135,
        total_revenue: 43_800_000,
        avg_unit_price: 3_080,
        rotation_rate: 2.7,
        inventory_turnover: 3.1
      },
      {
        month: "2025-09",
        total_staff: 160,
        active_staff: 140,
        total_revenue: 48_600_000,
        avg_unit_price: 3_200,
        rotation_rate: 3.0,
        inventory_turnover: 3.5
      },
      {
        month: "2025-10",
        total_staff: 165,
        active_staff: 145,
        total_revenue: 51_200_000,
        avg_unit_price: 3_250,
        rotation_rate: 3.1,
        inventory_turnover: 3.6
      },
      {
        month: "2025-11",
        total_staff: 170,
        active_staff: 150,
        total_revenue: 52_800_000,
        avg_unit_price: 3_280,
        rotation_rate: 3.1,
        inventory_turnover: 3.6
      }
    ]

    # スキル別収益性
    @skill_profitability = [
      { skill: "接客", staff_count: 85, avg_rate: 3_100, monthly_revenue: 15_200_000, rotation: 2.8 },
      { skill: "英語", staff_count: 42, avg_rate: 3_600, monthly_revenue: 8_500_000, rotation: 3.2 },
      { skill: "イベント経験", staff_count: 68, avg_rate: 3_200, monthly_revenue: 12_800_000, rotation: 2.9 },
      { skill: "展示会経験", staff_count: 38, avg_rate: 2_900, monthly_revenue: 6_200_000, rotation: 2.7 },
      { skill: "フォーマル対応", staff_count: 45, avg_rate: 3_300, monthly_revenue: 8_900_000, rotation: 3.0 },
      { skill: "VIP対応", staff_count: 28, avg_rate: 3_500, monthly_revenue: 5_800_000, rotation: 3.1 }
    ]

    # サマリー
    @summary = {
      avg_unit_price: 3_280,
      avg_rotation_rate: 3.1,
      avg_inventory_turnover: 3.6,
      total_revenue: 52_800_000,
      revenue_per_staff: 310_588,
      target_rotation: 3.5,
      gap: -0.4
    }
  end
end
