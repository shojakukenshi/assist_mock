class Admin::Staffing::SupportController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "手配管理", path: admin_staffing_support_index_path },
      { name: "スタッフサポート", path: admin_staffing_support_index_path }
    ]

    # KPIサマリー
    @summary = {
      total_inquiries: 156,
      open: 18,
      in_progress: 12,
      closed_this_month: 42,
      avg_response_time: 2.5,
      satisfaction_rate: 92.3
    }

    # 問い合わせ一覧
    @inquiries = [
      {
        id: 1,
        ticket_number: "INQ-2025-1101",
        created_at: "2025-11-11 14:30",
        staff_code: "ST-0002",
        staff_name: "鈴木花子",
        category: "勤怠・労務",
        title: "勤怠打刻の修正について",
        status: "対応中",
        priority: "中",
        assigned_to: "サポート担当A",
        last_reply_at: "2025-11-11 15:00",
        messages_count: 3,
        satisfaction_rating: nil
      },
      {
        id: 2,
        ticket_number: "INQ-2025-1102",
        created_at: "2025-11-11 10:15",
        staff_code: "ST-0005",
        staff_name: "高橋健太",
        category: "契約・条件",
        title: "次期案件の単価交渉について",
        status: "新規",
        priority: "高",
        assigned_to: nil,
        last_reply_at: nil,
        messages_count: 1,
        satisfaction_rating: nil
      },
      {
        id: 3,
        ticket_number: "INQ-2025-1098",
        created_at: "2025-11-10 16:45",
        staff_code: "ST-0007",
        staff_name: "渡辺翔太",
        category: "現場トラブル",
        title: "客先での作業環境について",
        status: "完了",
        priority: "高",
        assigned_to: "サポート担当B",
        last_reply_at: "2025-11-11 09:30",
        messages_count: 5,
        satisfaction_rating: 5
      },
      {
        id: 4,
        ticket_number: "INQ-2025-1099",
        created_at: "2025-11-10 13:20",
        staff_code: "ST-0003",
        staff_name: "田中一郎",
        category: "キャリア相談",
        title: "スキルアップ研修の受講について",
        status: "対応中",
        priority: "低",
        assigned_to: "サポート担当A",
        last_reply_at: "2025-11-11 11:00",
        messages_count: 4,
        satisfaction_rating: nil
      },
      {
        id: 5,
        ticket_number: "INQ-2025-1100",
        created_at: "2025-11-10 11:05",
        staff_code: "ST-0011",
        staff_name: "松本愛",
        category: "給与・経費",
        title: "交通費の精算について",
        status: "完了",
        priority: "中",
        assigned_to: "サポート担当C",
        last_reply_at: "2025-11-10 14:30",
        messages_count: 2,
        satisfaction_rating: 4
      },
      {
        id: 6,
        ticket_number: "INQ-2025-1097",
        created_at: "2025-11-09 15:50",
        staff_code: "ST-0001",
        staff_name: "山本太郎",
        category: "システム・ツール",
        title: "勤怠システムのログインエラー",
        status: "完了",
        priority: "高",
        assigned_to: "サポート担当B",
        last_reply_at: "2025-11-09 17:20",
        messages_count: 4,
        satisfaction_rating: 5
      },
      {
        id: 7,
        ticket_number: "INQ-2025-1096",
        created_at: "2025-11-09 09:30",
        staff_code: "ST-0006",
        staff_name: "伊藤里奈",
        category: "契約・条件",
        title: "次期案件の紹介依頼",
        status: "対応中",
        priority: "中",
        assigned_to: "サポート担当A",
        last_reply_at: "2025-11-10 10:00",
        messages_count: 6,
        satisfaction_rating: nil
      },
      {
        id: 8,
        ticket_number: "INQ-2025-1095",
        created_at: "2025-11-08 14:00",
        staff_code: "ST-0004",
        staff_name: "佐藤美咲",
        category: "健康・安全",
        title: "健康診断の受診について",
        status: "完了",
        priority: "低",
        assigned_to: "サポート担当C",
        last_reply_at: "2025-11-08 16:45",
        messages_count: 2,
        satisfaction_rating: 4
      }
    ]

    # チャット履歴サンプル（問い合わせID: 1用）
    @chat_messages = [
      {
        id: 1,
        sender_type: "staff",
        sender_name: "鈴木花子",
        message: "11/11の出勤時刻の打刻を忘れてしまいました。修正をお願いできますでしょうか。",
        timestamp: "2025-11-11 14:30",
        read: true
      },
      {
        id: 2,
        sender_type: "support",
        sender_name: "サポート担当A",
        message: "鈴木様、お問い合わせありがとうございます。11/11の出勤時刻について確認させていただきます。何時頃に出勤されましたでしょうか？",
        timestamp: "2025-11-11 14:45",
        read: true
      },
      {
        id: 3,
        sender_type: "staff",
        sender_name: "鈴木花子",
        message: "10:00に出勤しました。よろしくお願いいたします。",
        timestamp: "2025-11-11 15:00",
        read: true
      }
    ]

    # お知らせ一覧
    @announcements = [
      {
        id: 1,
        title: "年末年始の営業日程について",
        content: "2025年12月28日（土）～2026年1月5日（日）は休業とさせていただきます。",
        category: "重要",
        posted_at: "2025-11-10 10:00",
        read_count: 142,
        target_count: 158
      },
      {
        id: 2,
        title: "健康診断の実施について",
        content: "12月中旬に定期健康診断を実施します。対象者には個別に連絡いたします。",
        category: "お知らせ",
        posted_at: "2025-11-08 15:00",
        read_count: 135,
        target_count: 158
      },
      {
        id: 3,
        title: "勤怠システムのメンテナンスのお知らせ",
        content: "11/15（金）23:00～11/16（土）03:00の間、勤怠システムのメンテナンスを実施します。",
        category: "メンテナンス",
        posted_at: "2025-11-05 09:00",
        read_count: 158,
        target_count: 158
      },
      {
        id: 4,
        title: "スキルアップ研修のご案内",
        content: "AWS認定資格取得支援プログラムを開始します。詳細は添付資料をご確認ください。",
        category: "研修",
        posted_at: "2025-11-01 10:00",
        read_count: 98,
        target_count: 158
      }
    ]

    # FAQ一覧
    @faqs = [
      {
        id: 1,
        category: "勤怠・労務",
        question: "勤怠の打刻を忘れた場合はどうすればよいですか？",
        answer: "サポートデスクにお問い合わせいただき、実際の勤務時間をお知らせください。確認後、勤怠データを修正いたします。",
        view_count: 245
      },
      {
        id: 2,
        category: "給与・経費",
        question: "交通費の精算方法を教えてください",
        answer: "勤怠システムの「経費精算」メニューから、交通費精算を申請してください。領収書がある場合は画像をアップロードしてください。",
        view_count: 189
      },
      {
        id: 3,
        category: "契約・条件",
        question: "契約更新の手続きはいつ行えばよいですか？",
        answer: "契約終了の1ヶ月前までに担当営業またはサポートデスクにご連絡ください。更新手続きをご案内いたします。",
        view_count: 156
      },
      {
        id: 4,
        category: "システム・ツール",
        question: "勤怠システムにログインできません",
        answer: "ブラウザのキャッシュをクリアしてから再度お試しください。それでも解決しない場合はサポートデスクまでお問い合わせください。",
        view_count: 134
      },
      {
        id: 5,
        category: "健康・安全",
        question: "健康診断の受診は必須ですか？",
        answer: "はい、労働安全衛生法により年1回の健康診断受診が義務付けられています。必ず受診してください。",
        view_count: 98
      }
    ]

    # カテゴリ別問い合わせ集計
    @category_summary = [
      { category: "勤怠・労務", count: 45, avg_resolution_days: 1.2 },
      { category: "給与・経費", count: 32, avg_resolution_days: 2.1 },
      { category: "契約・条件", count: 28, avg_resolution_days: 3.5 },
      { category: "現場トラブル", count: 22, avg_resolution_days: 1.8 },
      { category: "システム・ツール", count: 18, avg_resolution_days: 0.8 },
      { category: "キャリア相談", count: 11, avg_resolution_days: 4.2 }
    ]

    # 問い合わせ推移（月次）
    @inquiry_trends = [
      { month: "2025-06", total: 38, resolved: 36, satisfaction: 91.2 },
      { month: "2025-07", total: 42, resolved: 40, satisfaction: 90.5 },
      { month: "2025-08", total: 35, resolved: 34, satisfaction: 93.1 },
      { month: "2025-09", total: 40, resolved: 39, satisfaction: 92.8 },
      { month: "2025-10", total: 45, resolved: 43, satisfaction: 91.8 },
      { month: "2025-11", total: 42, resolved: 42, satisfaction: 92.3 }
    ]
  end
end
