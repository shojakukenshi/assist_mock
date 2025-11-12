class Admin::Settings::EmployeesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_employees_path },
      { name: "社員管理", path: admin_settings_employees_path }
    ]

    # KPIサマリー
    @summary = {
      total_employees: 12,
      active: 10,
      inactive: 2,
      admin_count: 3,
      sales_count: 4,
      staffing_count: 3,
      accounting_count: 2
    }

    # 社員一覧（イベントスタッフ派遣業務の社員）
    @employees = [
      {
        id: 1,
        code: "EMP-001",
        name: "佐藤花子",
        name_kana: "サトウハナコ",
        email: "sato.hanako@company.co.jp",
        department: "営業部",
        position: "営業マネージャー",
        role: "admin",
        status: "稼働中",
        join_date: "2020-04-01",
        phone: "03-1111-1111",
        mobile: "090-1111-1111",
        last_login: "2025-11-12 09:30",
        login_count: 1245,
        created_at: "2020-04-01"
      },
      {
        id: 2,
        code: "EMP-002",
        name: "田中次郎",
        name_kana: "タナカジロウ",
        email: "tanaka.jiro@company.co.jp",
        department: "営業部",
        position: "営業担当",
        role: "sales",
        status: "稼働中",
        join_date: "2021-06-15",
        phone: "03-2222-2222",
        mobile: "090-2222-2222",
        last_login: "2025-11-12 08:45",
        login_count: 892,
        created_at: "2021-06-15"
      },
      {
        id: 3,
        code: "EMP-003",
        name: "伊藤健太",
        name_kana: "イトウケンタ",
        email: "ito.kenta@company.co.jp",
        department: "営業部",
        position: "営業担当",
        role: "sales",
        status: "稼働中",
        join_date: "2022-01-10",
        phone: "03-3333-3333",
        mobile: "090-3333-3333",
        last_login: "2025-11-11 18:20",
        login_count: 654,
        created_at: "2022-01-10"
      },
      {
        id: 4,
        code: "EMP-004",
        name: "鈴木美咲",
        name_kana: "スズキミサキ",
        email: "suzuki.misaki@company.co.jp",
        department: "営業部",
        position: "営業担当",
        role: "sales",
        status: "稼働中",
        join_date: "2022-04-01",
        phone: "03-4444-4444",
        mobile: "090-4444-4444",
        last_login: "2025-11-12 10:15",
        login_count: 582,
        created_at: "2022-04-01"
      },
      {
        id: 5,
        code: "EMP-005",
        name: "高橋美穂",
        name_kana: "タカハシミホ",
        email: "takahashi.miho@company.co.jp",
        department: "手配部",
        position: "手配マネージャー",
        role: "admin",
        status: "稼働中",
        join_date: "2019-10-01",
        phone: "03-5555-5555",
        mobile: "090-5555-5555",
        last_login: "2025-11-12 09:00",
        login_count: 1567,
        created_at: "2019-10-01"
      },
      {
        id: 6,
        code: "EMP-006",
        name: "渡辺翔太",
        name_kana: "ワタナベショウタ",
        email: "watanabe.shota@company.co.jp",
        department: "手配部",
        position: "手配担当",
        role: "staffing",
        status: "稼働中",
        join_date: "2021-08-01",
        phone: "03-6666-6666",
        mobile: "090-6666-6666",
        last_login: "2025-11-12 08:30",
        login_count: 823,
        created_at: "2021-08-01"
      },
      {
        id: 7,
        code: "EMP-007",
        name: "中村里奈",
        name_kana: "ナカムラリナ",
        email: "nakamura.rina@company.co.jp",
        department: "手配部",
        position: "手配担当",
        role: "staffing",
        status: "稼働中",
        join_date: "2022-10-01",
        phone: "03-7777-7777",
        mobile: "090-7777-7777",
        last_login: "2025-11-11 17:45",
        login_count: 412,
        created_at: "2022-10-01"
      },
      {
        id: 8,
        code: "EMP-008",
        name: "小林誠",
        name_kana: "コバヤシマコト",
        email: "kobayashi.makoto@company.co.jp",
        department: "経理部",
        position: "経理マネージャー",
        role: "admin",
        status: "稼働中",
        join_date: "2018-04-01",
        phone: "03-8888-8888",
        mobile: "090-8888-8888",
        last_login: "2025-11-12 09:45",
        login_count: 1892,
        created_at: "2018-04-01"
      },
      {
        id: 9,
        code: "EMP-009",
        name: "加藤由美",
        name_kana: "カトウユミ",
        email: "kato.yumi@company.co.jp",
        department: "経理部",
        position: "経理担当",
        role: "accounting",
        status: "稼働中",
        join_date: "2020-07-15",
        phone: "03-9999-9999",
        mobile: "090-9999-9999",
        last_login: "2025-11-12 08:15",
        login_count: 1123,
        created_at: "2020-07-15"
      },
      {
        id: 10,
        code: "EMP-010",
        name: "山本大介",
        name_kana: "ヤマモトダイスケ",
        email: "yamamoto.daisuke@company.co.jp",
        department: "総務部",
        position: "システム管理者",
        role: "admin",
        status: "稼働中",
        join_date: "2019-04-01",
        phone: "03-0000-0001",
        mobile: "090-0000-0001",
        last_login: "2025-11-12 07:30",
        login_count: 1678,
        created_at: "2019-04-01"
      },
      {
        id: 11,
        code: "EMP-011",
        name: "森田愛",
        name_kana: "モリタアイ",
        email: "morita.ai@company.co.jp",
        department: "営業部",
        position: "営業アシスタント",
        role: "sales",
        status: "休職中",
        join_date: "2023-04-01",
        phone: "03-0000-0002",
        mobile: "090-0000-0002",
        last_login: "2025-09-30 17:00",
        login_count: 156,
        created_at: "2023-04-01"
      },
      {
        id: 12,
        code: "EMP-012",
        name: "吉田健",
        name_kana: "ヨシダケン",
        email: "yoshida.ken@company.co.jp",
        department: "手配部",
        position: "手配アシスタント",
        role: "staffing",
        status: "退職済",
        join_date: "2021-04-01",
        phone: nil,
        mobile: nil,
        last_login: "2025-08-31 18:00",
        login_count: 389,
        created_at: "2021-04-01"
      }
    ]

    # 権限定義
    @roles = [
      { value: "admin", label: "管理者", description: "全機能へのアクセス権限" },
      { value: "sales", label: "営業担当", description: "営業機能へのアクセス権限" },
      { value: "staffing", label: "手配担当", description: "手配機能へのアクセス権限" },
      { value: "accounting", label: "経理担当", description: "経理機能へのアクセス権限" },
      { value: "viewer", label: "閲覧のみ", description: "閲覧のみの権限" }
    ]

    # 部署一覧
    @departments = ["営業部", "手配部", "経理部", "総務部", "人事部"]
  end

  def show
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_employees_path },
      { name: "社員管理", path: admin_settings_employees_path },
      { name: "社員詳細", path: admin_settings_employee_path(params[:id]) }
    ]
  end

  def new
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_employees_path },
      { name: "社員管理", path: admin_settings_employees_path },
      { name: "新規登録", path: new_admin_settings_employee_path }
    ]
  end

  def edit
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_employees_path },
      { name: "社員管理", path: admin_settings_employees_path },
      { name: "編集", path: edit_admin_settings_employee_path(params[:id]) }
    ]
  end
end
