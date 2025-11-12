class Admin::Settings::MastersController < Admin::BaseController
  def index
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path }
    ]

    # マスタ一覧
    @masters = [
      {
        id: "belongings",
        name: "持ち物マスター",
        description: "イベント時のスタッフ必携品管理",
        count: 15,
        last_updated: "2025-11-10",
        path: belongings_admin_settings_masters_path
      },
      {
        id: "appearance",
        name: "身だしなみマスター",
        description: "イベントスタッフの身だしなみ基準",
        count: 12,
        last_updated: "2025-11-08",
        path: appearance_admin_settings_masters_path
      },
      {
        id: "ip_addresses",
        name: "アクセスIPアドレス",
        description: "許可IPアドレスの管理",
        count: 8,
        last_updated: "2025-11-05",
        path: ip_addresses_admin_settings_masters_path
      },
      {
        id: "notification_emails",
        name: "案件応募通知メールアドレスマスター",
        description: "スタッフ応募時の通知先メールアドレス",
        count: 5,
        last_updated: "2025-11-12",
        path: notification_emails_admin_settings_masters_path
      },
      {
        id: "salary_tables",
        name: "支払い給与表",
        description: "職種・スキル別の給与テーブル",
        count: 24,
        last_updated: "2025-11-01",
        path: salary_tables_admin_settings_masters_path
      },
      {
        id: "mynumber_purposes",
        name: "マイナンバー利用目的マスター",
        description: "マイナンバーの利用目的管理",
        count: 6,
        last_updated: "2025-10-15",
        path: mynumber_purposes_admin_settings_masters_path
      }
    ]
  end

  # 持ち物マスター
  def belongings
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "持ち物マスター", path: belongings_admin_settings_masters_path }
    ]

    @belongings = [
      { id: 1, category: "基本", item: "社員証・身分証明書", required: true, description: "本人確認用", display_order: 1 },
      { id: 2, category: "基本", item: "名刺", required: true, description: "自己紹介・挨拶用", display_order: 2 },
      { id: 3, category: "基本", item: "筆記用具（黒ボールペン）", required: true, description: "記録・署名用", display_order: 3 },
      { id: 4, category: "基本", item: "メモ帳", required: true, description: "業務メモ用", display_order: 4 },
      { id: 5, category: "服装", item: "黒スーツ", required: true, description: "フォーマルイベント用", display_order: 5 },
      { id: 6, category: "服装", item: "白シャツ", required: true, description: "フォーマルイベント用", display_order: 6 },
      { id: 7, category: "服装", item: "黒革靴", required: true, description: "フォーマルイベント用", display_order: 7 },
      { id: 8, category: "服装", item: "ポロシャツ（支給品）", required: false, description: "カジュアルイベント用", display_order: 8 },
      { id: 9, category: "装備", item: "スマートフォン", required: true, description: "連絡・報告用", display_order: 9 },
      { id: 10, category: "装備", item: "腕時計", required: true, description: "時間管理用", display_order: 10 },
      { id: 11, category: "装備", item: "インカム（支給）", required: false, description: "大規模イベント時の連絡用", display_order: 11 },
      { id: 12, category: "その他", item: "ハンカチ・ティッシュ", required: true, description: "身だしなみ用", display_order: 12 },
      { id: 13, category: "その他", item: "折りたたみ傘", required: false, description: "雨天対応用", display_order: 13 },
      { id: 14, category: "その他", item: "マスク（予備）", required: true, description: "衛生管理用", display_order: 14 },
      { id: 15, category: "その他", item: "飲料水", required: false, description: "長時間イベント時", display_order: 15 }
    ]
  end

  # 身だしなみマスター
  def appearance
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "身だしなみマスター", path: appearance_admin_settings_masters_path }
    ]

    @appearance_standards = [
      { id: 1, category: "髪型", item: "清潔で整った髪型", standard: "前髪は目にかからない長さ、耳にかからない長さ", gender: "男性", display_order: 1 },
      { id: 2, category: "髪型", item: "派手な髪色の禁止", standard: "黒または自然な茶色のみ", gender: "共通", display_order: 2 },
      { id: 3, category: "髪型", item: "長髪の場合", standard: "肩にかかる長さの場合はまとめる", gender: "女性", display_order: 3 },
      { id: 4, category: "顔", item: "ひげ", standard: "清潔に剃る（無精ひげ禁止）", gender: "男性", display_order: 4 },
      { id: 5, category: "顔", item: "メイク", standard: "ナチュラルメイク（派手な化粧禁止）", gender: "女性", display_order: 5 },
      { id: 6, category: "アクセサリー", item: "ピアス・イヤリング", standard: "小ぶりで目立たないもの1つまで", gender: "女性", display_order: 6 },
      { id: 7, category: "アクセサリー", item: "指輪", standard: "結婚指輪のみ可", gender: "共通", display_order: 7 },
      { id: 8, category: "アクセサリー", item: "ネックレス", standard: "原則禁止（見えないものは可）", gender: "共通", display_order: 8 },
      { id: 9, category: "爪", item: "爪の長さ", standard: "短く整える（深爪しない程度）", gender: "共通", display_order: 9 },
      { id: 10, category: "爪", item: "ネイル", standard: "派手なネイル禁止（透明・ベージュのみ可）", gender: "女性", display_order: 10 },
      { id: 11, category: "服装", item: "清潔感", standard: "しわ・汚れのない清潔な服装", gender: "共通", display_order: 11 },
      { id: 12, category: "その他", item: "香水・整髪料", standard: "強い香りは控える", gender: "共通", display_order: 12 }
    ]
  end

  # アクセスIPアドレス
  def ip_addresses
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "アクセスIPアドレス", path: ip_addresses_admin_settings_masters_path }
    ]

    @ip_addresses = [
      { id: 1, ip_address: "203.0.113.10", description: "本社オフィス", status: "有効", added_date: "2020-04-01", last_accessed: "2025-11-12 09:30" },
      { id: 2, ip_address: "203.0.113.11", description: "本社オフィス（予備）", status: "有効", added_date: "2020-04-01", last_accessed: "2025-11-10 14:20" },
      { id: 3, ip_address: "198.51.100.20", description: "大阪支社", status: "有効", added_date: "2021-06-01", last_accessed: "2025-11-12 08:45" },
      { id: 4, ip_address: "192.0.2.30", description: "名古屋支社", status: "有効", added_date: "2022-03-01", last_accessed: "2025-11-11 16:30" },
      { id: 5, ip_address: "198.18.0.40", description: "福岡支社", status: "有効", added_date: "2023-01-15", last_accessed: "2025-11-12 10:15" },
      { id: 6, ip_address: "203.0.113.100", description: "VPN接続用", status: "有効", added_date: "2020-04-01", last_accessed: "2025-11-12 07:20" },
      { id: 7, ip_address: "192.0.2.200", description: "テスト環境", status: "有効", added_date: "2024-05-01", last_accessed: "2025-11-09 18:00" },
      { id: 8, ip_address: "198.51.100.50", description: "旧オフィス", status: "無効", added_date: "2019-04-01", last_accessed: "2024-03-31 23:59" }
    ]
  end

  # 案件応募通知メールアドレスマスター
  def notification_emails
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "案件応募通知メールアドレスマスター", path: notification_emails_admin_settings_masters_path }
    ]

    @notification_emails = [
      { id: 1, name: "営業部全体", email: "sales@company.co.jp", description: "全営業案件の応募通知", status: "有効", added_date: "2020-04-01" },
      { id: 2, name: "手配部全体", email: "staffing@company.co.jp", description: "全スタッフ応募通知", status: "有効", added_date: "2020-04-01" },
      { id: 3, name: "営業マネージャー", email: "sato.hanako@company.co.jp", description: "重要案件の応募通知", status: "有効", added_date: "2020-04-01" },
      { id: 4, name: "手配マネージャー", email: "takahashi.miho@company.co.jp", description: "緊急案件の応募通知", status: "有効", added_date: "2019-10-01" },
      { id: 5, name: "システム管理者", email: "yamamoto.daisuke@company.co.jp", description: "システムエラー通知", status: "有効", added_date: "2019-04-01" }
    ]
  end

  # 支払い給与表
  def salary_tables
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "支払い給与表", path: salary_tables_admin_settings_masters_path }
    ]

    @salary_tables = [
      { id: 1, category: "受付・案内", skill_level: "初級", hourly_rate: 2_500, description: "基本的な受付・案内業務", effective_from: "2025-04-01" },
      { id: 2, category: "受付・案内", skill_level: "中級", hourly_rate: 2_800, description: "複雑な案内・誘導業務", effective_from: "2025-04-01" },
      { id: 3, category: "受付・案内", skill_level: "上級", hourly_rate: 3_200, description: "VIP対応・通訳可能", effective_from: "2025-04-01" },
      { id: 4, category: "展示会", skill_level: "初級", hourly_rate: 2_700, description: "基本的な展示会サポート", effective_from: "2025-04-01" },
      { id: 5, category: "展示会", skill_level: "中級", hourly_rate: 3_000, description: "出展サポート・商品説明", effective_from: "2025-04-01" },
      { id: 6, category: "展示会", skill_level: "上級", hourly_rate: 3_500, description: "展示会運営・統括", effective_from: "2025-04-01" },
      { id: 7, category: "イベント運営", skill_level: "初級", hourly_rate: 2_600, description: "基本的なイベントサポート", effective_from: "2025-04-01" },
      { id: 8, category: "イベント運営", skill_level: "中級", hourly_rate: 3_100, description: "セクション責任者", effective_from: "2025-04-01" },
      { id: 9, category: "イベント運営", skill_level: "上級", hourly_rate: 3_800, description: "イベント統括・進行管理", effective_from: "2025-04-01" },
      { id: 10, category: "フォーマル", skill_level: "初級", hourly_rate: 2_800, description: "基本的なフォーマル対応", effective_from: "2025-04-01" },
      { id: 11, category: "フォーマル", skill_level: "中級", hourly_rate: 3_300, description: "VIP対応可能", effective_from: "2025-04-01" },
      { id: 12, category: "フォーマル", skill_level: "上級", hourly_rate: 4_000, description: "国際会議・VIP専門", effective_from: "2025-04-01" },
      { id: 13, category: "ブライダル", skill_level: "初級", hourly_rate: 2_700, description: "基本的な式場サポート", effective_from: "2025-04-01" },
      { id: 14, category: "ブライダル", skill_level: "中級", hourly_rate: 3_200, description: "配膳・クローク対応", effective_from: "2025-04-01" },
      { id: 15, category: "ブライダル", skill_level: "上級", hourly_rate: 3_800, description: "式進行・統括", effective_from: "2025-04-01" },
      { id: 16, category: "通訳", skill_level: "英語（日常）", hourly_rate: 3_500, description: "日常会話レベル", effective_from: "2025-04-01" },
      { id: 17, category: "通訳", skill_level: "英語（ビジネス）", hourly_rate: 4_200, description: "ビジネスレベル", effective_from: "2025-04-01" },
      { id: 18, category: "通訳", skill_level: "英語（専門）", hourly_rate: 5_000, description: "専門分野の通訳", effective_from: "2025-04-01" },
      { id: 19, category: "通訳", skill_level: "中国語", hourly_rate: 4_000, description: "中国語対応", effective_from: "2025-04-01" },
      { id: 20, category: "通訳", skill_level: "その他言語", hourly_rate: 4_500, description: "韓国語・フランス語等", effective_from: "2025-04-01" },
      { id: 21, category: "設営・撤去", skill_level: "一般", hourly_rate: 2_800, description: "基本的な設営作業", effective_from: "2025-04-01" },
      { id: 22, category: "設営・撤去", skill_level: "重機操作", hourly_rate: 3_500, description: "フォークリフト等操作", effective_from: "2025-04-01" },
      { id: 23, category: "夜間・早朝", skill_level: "深夜割増", hourly_rate: 3_200, description: "22時以降の勤務", effective_from: "2025-04-01" },
      { id: 24, category: "夜間・早朝", skill_level: "早朝割増", hourly_rate: 3_000, description: "6時以前の勤務", effective_from: "2025-04-01" }
    ]
  end

  # マイナンバー利用目的マスター
  def mynumber_purposes
    @breadcrumbs = [
      { name: "ダッシュボード", path: admin_dashboard_path },
      { name: "システム設定", path: admin_settings_masters_path },
      { name: "マスタ管理", path: admin_settings_masters_path },
      { name: "マイナンバー利用目的マスター", path: mynumber_purposes_admin_settings_masters_path }
    ]

    @mynumber_purposes = [
      {
        id: 1,
        purpose: "給与所得の源泉徴収票作成事務",
        legal_basis: "所得税法第226条",
        description: "従業員の給与支払いに伴う源泉徴収票の作成",
        status: "有効",
        effective_from: "2016-01-01"
      },
      {
        id: 2,
        purpose: "雇用保険届出事務",
        legal_basis: "雇用保険法第7条",
        description: "雇用保険の資格取得・喪失等の届出",
        status: "有効",
        effective_from: "2016-01-01"
      },
      {
        id: 3,
        purpose: "健康保険・厚生年金保険届出事務",
        legal_basis: "健康保険法第48条、厚生年金保険法第27条",
        description: "健康保険・厚生年金保険の資格取得・喪失等の届出",
        status: "有効",
        effective_from: "2016-01-01"
      },
      {
        id: 4,
        purpose: "報酬、料金、契約金及び賞金の支払調書作成事務",
        legal_basis: "所得税法第225条",
        description: "外部スタッフへの報酬支払いに伴う支払調書の作成",
        status: "有効",
        effective_from: "2016-01-01"
      },
      {
        id: 5,
        purpose: "健康保険・厚生年金保険被扶養者届出事務",
        legal_basis: "健康保険法第50条、厚生年金保険法第28条",
        description: "被扶養者の資格取得・喪失等の届出",
        status: "有効",
        effective_from: "2016-01-01"
      },
      {
        id: 6,
        purpose: "国民年金第3号被保険者届出事務",
        legal_basis: "国民年金法第12条",
        description: "国民年金第3号被保険者の資格取得・喪失等の届出",
        status: "有効",
        effective_from: "2016-01-01"
      }
    ]
  end
end
