class Admin::ApplicationsController < Admin::BaseController
  before_action :set_project
  before_action :set_application, only: [:show, :accept, :reject]

  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path },
      { name: @project[:name], path: admin_project_path(@project[:id]) },
      { name: "応募一覧", path: admin_project_applications_path(@project[:id]) }
    ]

    # 応募一覧（モックデータ）
    @applications = [
      {
        id: 1,
        project_id: @project[:id],
        staff_id: 1,
        staff_name: "山田太郎",
        staff_skills: ["Ruby", "Rails", "React", "AWS"],
        staff_experience_years: 8,
        staff_rating: 4.9,
        applied_at: "2025-11-10 10:30",
        status: "pending",
        message: "このプロジェクトに大変興味があります。ECサイト開発の経験が豊富で、貴社のプロジェクトに貢献できると考えています。"
      },
      {
        id: 2,
        project_id: @project[:id],
        staff_id: 2,
        staff_name: "佐藤次郎",
        staff_skills: ["Ruby", "Rails", "PostgreSQL", "Docker"],
        staff_experience_years: 6,
        staff_rating: 4.7,
        applied_at: "2025-11-11 14:20",
        status: "pending",
        message: "11月30日以降であれば参画可能です。バックエンド開発を担当させていただければと思います。"
      }
    ]
  end

  def show
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "案件管理", path: admin_projects_path },
      { name: @project[:name], path: admin_project_path(@project[:id]) },
      { name: "応募一覧", path: admin_project_applications_path(@project[:id]) },
      { name: "応募詳細", path: admin_project_application_path(@project[:id], @application[:id]) }
    ]
  end

  # 配置確定
  def accept
    # 実際はDBに保存するが、モックなのでフラッシュメッセージのみ
    assignment_params = params.permit(:role, :responsibilities, :start_date, :end_date, :unit_price, :notes)

    flash[:success] = "#{@application[:staff_name]}さんの配置を確定しました。"
    redirect_to admin_projects_path
  end

  # お断り
  def reject
    reason = params[:reject_reason] || ""

    flash[:success] = "#{@application[:staff_name]}さんの応募をお断りしました。"
    redirect_to admin_project_applications_path(@project[:id])
  end

  private

  def set_project
    # モックデータ
    projects_data = [
      {
        id: 1,
        name: "ECサイトリニューアルプロジェクト",
        client_name: "株式会社サンプルテクノロジー",
        status: "確定",
        start_date: "2025-01-15",
        end_date: "2025-06-30",
        unit_price: 850_000
      },
      {
        id: 4,
        name: "データ分析基盤構築",
        client_name: "株式会社ビッグデータソリューションズ",
        status: "確定",
        start_date: "2025-01-10",
        end_date: "2025-12-31",
        unit_price: 1_000_000
      },
      {
        id: 11,
        name: "SaaS開発プロジェクト",
        client_name: "株式会社イノベーション",
        status: "確定",
        start_date: "2025-02-01",
        end_date: "2025-12-31",
        unit_price: 950_000
      }
    ]

    @project = projects_data.find { |p| p[:id] == params[:project_id].to_i }
  end

  def set_application
    # モックデータ
    applications_data = [
      {
        id: 1,
        project_id: 1,
        staff_id: 1,
        staff_name: "山田太郎",
        staff_email: "yamada@example.com",
        staff_phone: "090-1234-5678",
        staff_skills: ["Ruby", "Rails", "React", "AWS"],
        staff_experience_years: 8,
        staff_rating: 4.9,
        staff_past_projects: 24,
        staff_location: "東京都",
        staff_certifications: ["AWS認定ソリューションアーキテクト", "Ruby Association Certified Ruby Programmer Gold"],
        applied_at: "2025-11-10 10:30",
        status: "pending",
        message: "このプロジェクトに大変興味があります。ECサイト開発の経験が豊富で、貴社のプロジェクトに貢献できると考えています。過去には大手企業のEC基盤開発に携わり、Railsでの大規模開発の経験があります。"
      },
      {
        id: 2,
        project_id: 4,
        staff_id: 2,
        staff_name: "佐藤次郎",
        staff_email: "sato@example.com",
        staff_phone: "090-2345-6789",
        staff_skills: ["Ruby", "Rails", "PostgreSQL", "Docker"],
        staff_experience_years: 6,
        staff_rating: 4.7,
        staff_past_projects: 18,
        staff_location: "神奈川県",
        staff_certifications: ["Ruby Association Certified Ruby Programmer Silver"],
        applied_at: "2025-11-11 14:20",
        status: "pending",
        message: "11月30日以降であれば参画可能です。バックエンド開発を担当させていただければと思います。データ分析基盤の開発経験があり、AWS環境での構築にも精通しています。"
      },
      {
        id: 3,
        project_id: 11,
        staff_id: 3,
        staff_name: "鈴木花子",
        staff_email: "suzuki@example.com",
        staff_phone: "090-3456-7890",
        staff_skills: ["Ruby", "Rails", "Vue.js", "GraphQL"],
        staff_experience_years: 5,
        staff_rating: 4.6,
        staff_past_projects: 15,
        staff_location: "東京都",
        staff_certifications: [],
        applied_at: "2025-11-12 09:15",
        status: "pending",
        message: "SaaS開発に興味があり、ぜひ参画させていただきたいです。API設計・開発の経験が豊富で、GraphQLを使ったモダンな開発にも対応できます。"
      }
    ]

    @application = applications_data.find { |a| a[:id] == params[:id].to_i }
  end
end
