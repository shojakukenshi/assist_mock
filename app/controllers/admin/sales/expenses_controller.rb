class Admin::Sales::ExpensesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "営業管理", path: admin_sales_pipeline_path },
      { name: "経費登録", path: admin_sales_expenses_path }
    ]

    # 経費カテゴリー
    @categories = [
      "交通費",
      "接待交際費",
      "会議費",
      "通信費",
      "消耗品費",
      "その他"
    ]

    # ステータスフィルター
    @statuses = ["承認待ち", "承認済", "差戻し"]

    # サマリー
    @summary = {
      total_expenses: 15,
      pending: 5,
      approved: 8,
      rejected: 2,
      total_amount: 285_000,
      pending_amount: 95_000
    }

    # 経費一覧データ
    @expenses = [
      {
        id: 1,
        date: "2025-11-12",
        category: "交通費",
        description: "クライアント訪問（渋谷→横浜）",
        amount: 1_500,
        status: "承認待ち",
        receipt: true,
        receipt_file: "receipt_001.pdf",
        submitted_at: "2025-11-12 10:30",
        approved_at: nil,
        approver: nil
      },
      {
        id: 2,
        date: "2025-11-11",
        category: "接待交際費",
        description: "株式会社サンプルテクノロジー様との会食",
        amount: 18_500,
        status: "承認待ち",
        receipt: true,
        receipt_file: "receipt_002.pdf",
        submitted_at: "2025-11-11 15:00",
        approved_at: nil,
        approver: nil
      },
      {
        id: 3,
        date: "2025-11-10",
        category: "交通費",
        description: "商談（品川→大手町）",
        amount: 800,
        status: "承認待ち",
        receipt: true,
        receipt_file: "receipt_003.jpg",
        submitted_at: "2025-11-10 18:00",
        approved_at: nil,
        approver: nil
      },
      {
        id: 4,
        date: "2025-11-09",
        category: "会議費",
        description: "打ち合わせ会議室利用（4時間）",
        amount: 8_000,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_004.pdf",
        submitted_at: "2025-11-09 17:00",
        approved_at: "2025-11-10 09:00",
        approver: "部長 山田太郎"
      },
      {
        id: 5,
        date: "2025-11-08",
        category: "交通費",
        description: "顧客先訪問（往復タクシー）",
        amount: 5_200,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_005.jpg",
        submitted_at: "2025-11-08 19:00",
        approved_at: "2025-11-09 10:00",
        approver: "部長 山田太郎"
      },
      {
        id: 6,
        date: "2025-11-07",
        category: "接待交際費",
        description: "取引先様との昼食ミーティング",
        amount: 12_000,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_006.pdf",
        submitted_at: "2025-11-07 14:30",
        approved_at: "2025-11-08 09:30",
        approver: "部長 山田太郎"
      },
      {
        id: 7,
        date: "2025-11-06",
        category: "交通費",
        description: "新幹線（東京→大阪 日帰り出張）",
        amount: 29_000,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_007.pdf",
        submitted_at: "2025-11-06 20:00",
        approved_at: "2025-11-07 10:00",
        approver: "部長 山田太郎"
      },
      {
        id: 8,
        date: "2025-11-05",
        category: "消耗品費",
        description: "営業資料用ファイル・文具",
        amount: 3_500,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_008.jpg",
        submitted_at: "2025-11-05 16:00",
        approved_at: "2025-11-06 09:00",
        approver: "部長 山田太郎"
      },
      {
        id: 9,
        date: "2025-11-04",
        category: "通信費",
        description: "営業用モバイルWi-Fi（月額）",
        amount: 4_800,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_009.pdf",
        submitted_at: "2025-11-04 11:00",
        approved_at: "2025-11-05 09:00",
        approver: "部長 山田太郎"
      },
      {
        id: 10,
        date: "2025-11-03",
        category: "交通費",
        description: "クライアント訪問（渋谷→新宿）",
        amount: 600,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_010.jpg",
        submitted_at: "2025-11-03 17:00",
        approved_at: "2025-11-04 09:00",
        approver: "部長 山田太郎"
      },
      {
        id: 11,
        date: "2025-11-02",
        category: "接待交際費",
        description: "見込み顧客との情報交換会",
        amount: 15_000,
        status: "差戻し",
        receipt: false,
        receipt_file: nil,
        submitted_at: "2025-11-02 18:00",
        approved_at: nil,
        approver: nil,
        reject_reason: "領収書が添付されていません"
      },
      {
        id: 12,
        date: "2025-11-01",
        category: "交通費",
        description: "商談（池袋→品川）",
        amount: 900,
        status: "承認済",
        receipt: true,
        receipt_file: "receipt_012.jpg",
        submitted_at: "2025-11-01 19:00",
        approved_at: "2025-11-02 09:00",
        approver: "部長 山田太郎"
      },
      {
        id: 13,
        date: "2025-10-31",
        category: "会議費",
        description: "営業会議用カフェ利用",
        amount: 2_500,
        status: "承認待ち",
        receipt: true,
        receipt_file: "receipt_013.pdf",
        submitted_at: "2025-10-31 15:00",
        approved_at: nil,
        approver: nil
      },
      {
        id: 14,
        date: "2025-10-30",
        category: "その他",
        description: "営業資料印刷代",
        amount: 6_800,
        status: "承認待ち",
        receipt: true,
        receipt_file: "receipt_014.pdf",
        submitted_at: "2025-10-30 16:00",
        approved_at: nil,
        approver: nil
      },
      {
        id: 15,
        date: "2025-10-29",
        category: "交通費",
        description: "顧客訪問（品川→横浜→品川）",
        amount: 2_100,
        status: "差戻し",
        receipt: true,
        receipt_file: "receipt_015.jpg",
        submitted_at: "2025-10-29 18:30",
        approved_at: nil,
        approver: nil,
        reject_reason: "金額が明細と一致しません。再提出してください。"
      }
    ]
  end
end
