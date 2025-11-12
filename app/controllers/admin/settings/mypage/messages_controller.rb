class Admin::Settings::Mypage::MessagesController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_mypage_path },
      { name: "マイページ", path: admin_settings_mypage_path },
      { name: "マイページメッセージ一覧", path: admin_settings_mypage_messages_path }
    ]

    # メッセージ一覧
    @messages = [
      {
        id: 1,
        title: "12月繁忙期のお知らせ",
        content: "12月は例年通り繁忙期となります。多数の案件が予定されておりますので、積極的なご応募をお待ちしております。",
        category: "重要",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-12 09:00",
        expiry_date: "2025-12-31 23:59",
        created_by: "佐藤花子",
        read_count: 142,
        total_recipients: 158
      },
      {
        id: 2,
        title: "安全衛生講習のご案内",
        content: "12月15日（日）13:00より、本社にて安全衛生講習を実施します。参加希望の方はマイページよりお申し込みください。",
        category: "お知らせ",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-11 10:00",
        expiry_date: "2025-12-14 23:59",
        created_by: "高橋美穂",
        read_count: 85,
        total_recipients: 158
      },
      {
        id: 3,
        title: "年末年始の営業について",
        content: "12月29日（日）～1月3日（金）は年末年始休業となります。緊急時の連絡先は別途お知らせします。",
        category: "お知らせ",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-10 15:00",
        expiry_date: "2026-01-03 23:59",
        created_by: "佐藤花子",
        read_count: 128,
        total_recipients: 158
      },
      {
        id: 4,
        title: "給与振込日変更のお知らせ",
        content: "12月の給与振込日は、銀行休業日の関係で12月26日（木）となります。",
        category: "重要",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-08 14:00",
        expiry_date: "2025-12-26 23:59",
        created_by: "小林誠",
        read_count: 156,
        total_recipients: 158
      },
      {
        id: 5,
        title: "新規案件：東京モーターショー2025",
        content: "11月20日～24日開催の東京モーターショーのスタッフを募集します。VIP対応、英語対応可能な方優遇。",
        category: "案件募集",
        status: "公開中",
        target: "経験者",
        publish_date: "2025-11-05 10:00",
        expiry_date: "2025-11-18 23:59",
        created_by: "佐藤花子",
        read_count: 95,
        total_recipients: 85
      },
      {
        id: 6,
        title: "マイページシステムメンテナンスのお知らせ",
        content: "11月20日（水）2:00～6:00の間、システムメンテナンスのためマイページにアクセスできません。",
        category: "システム",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-01 16:00",
        expiry_date: "2025-11-20 23:59",
        created_by: "山本大介",
        read_count: 145,
        total_recipients: 158
      },
      {
        id: 7,
        title: "スキル登録キャンペーン",
        content: "マイページにてスキル情報を登録いただいた方に、QUOカード1,000円分をプレゼント！11月30日まで。",
        category: "キャンペーン",
        status: "公開中",
        target: "未登録者",
        publish_date: "2025-11-01 10:00",
        expiry_date: "2025-11-30 23:59",
        created_by: "高橋美穂",
        read_count: 68,
        total_recipients: 92
      },
      {
        id: 8,
        title: "10月の優秀スタッフ表彰",
        content: "10月の優秀スタッフとして、山本太郎さん、鈴木花子さんを表彰します。おめでとうございます！",
        category: "表彰",
        status: "公開中",
        target: "全スタッフ",
        publish_date: "2025-11-01 09:00",
        expiry_date: "2025-11-30 23:59",
        created_by: "佐藤花子",
        read_count: 132,
        total_recipients: 158
      },
      {
        id: 9,
        title: "マイナンバー提出のお願い",
        content: "まだマイナンバーをご提出いただいていない方は、速やかにご提出をお願いします。",
        category: "重要",
        status: "下書き",
        target: "未提出者",
        publish_date: nil,
        expiry_date: nil,
        created_by: "小林誠",
        read_count: 0,
        total_recipients: 0
      },
      {
        id: 10,
        title: "夏季賞与支給のお知らせ",
        content: "6月25日に夏季賞与を支給いたします。詳細は給与明細をご確認ください。",
        category: "お知らせ",
        status: "公開終了",
        target: "全スタッフ",
        publish_date: "2025-06-15 10:00",
        expiry_date: "2025-06-30 23:59",
        created_by: "小林誠",
        read_count: 158,
        total_recipients: 158
      }
    ]

    # カテゴリー定義
    @categories = ["重要", "お知らせ", "案件募集", "システム", "キャンペーン", "表彰"]

    # ターゲット定義
    @targets = [
      { value: "all", label: "全スタッフ" },
      { value: "experienced", label: "経験者" },
      { value: "beginners", label: "初心者" },
      { value: "active", label: "稼働中スタッフ" },
      { value: "inactive", label: "待機中スタッフ" },
      { value: "custom", label: "カスタム選択" }
    ]

    # サマリー
    @summary = {
      total_messages: 10,
      published: 8,
      draft: 1,
      expired: 1,
      total_reads: 1_109,
      avg_read_rate: 84.2
    }
  end

  def edit_message
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_mypage_path },
      { name: "マイページ", path: admin_settings_mypage_path },
      { name: "マイページメッセージ一覧", path: admin_settings_mypage_messages_path },
      { name: "メッセージ編集", path: admin_settings_mypage_edit_message_path }
    ]

    # 編集対象メッセージ（例）
    @message = {
      id: params[:id] || 1,
      title: "12月繁忙期のお知らせ",
      content: "12月は例年通り繁忙期となります。多数の案件が予定されておりますので、積極的なご応募をお待ちしております。",
      category: "重要",
      target: "all",
      publish_date: "2025-11-12 09:00",
      expiry_date: "2025-12-31 23:59"
    }
  end

  def update_message
    # 実際の更新処理はここに実装
    flash[:success] = "メッセージを更新しました。"
    redirect_to admin_settings_mypage_messages_path
  end
end
