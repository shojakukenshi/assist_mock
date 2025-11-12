import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["panel", "name", "age", "gender", "phone", "email", "position", "experience", "appliedDate", "status", "skills", "interviewCount", "lastInterviewDate", "nextAction", "referralSource", "remarks", "actionButtons"]
  static values = {
    applicant: Object
  }

  connect() {
    console.log("Recruitment detail controller connected")
  }

  // 詳細パネルを開く
  openDetail(event) {
    const row = event.currentTarget
    const applicantData = JSON.parse(row.dataset.applicant)

    this.applicantValue = applicantData
    this.updatePanel()
    this.showPanel()
  }

  // パネル内容を更新
  updatePanel() {
    const applicant = this.applicantValue

    if (this.hasNameTarget) this.nameTarget.textContent = applicant.name
    if (this.hasAgeTarget) this.ageTarget.textContent = `${applicant.age}歳`
    if (this.hasGenderTarget) this.genderTarget.textContent = applicant.gender
    if (this.hasPhoneTarget) this.phoneTarget.textContent = applicant.phone
    if (this.hasEmailTarget) this.emailTarget.textContent = applicant.email
    if (this.hasPositionTarget) this.positionTarget.textContent = applicant.position
    if (this.hasExperienceTarget) this.experienceTarget.textContent = `${applicant.experience_years}年`
    if (this.hasAppliedDateTarget) this.appliedDateTarget.textContent = applicant.applied_date
    if (this.hasStatusTarget) {
      this.statusTarget.textContent = applicant.status
      this.statusTarget.className = this.getStatusClass(applicant.status)
    }
    if (this.hasInterviewCountTarget) this.interviewCountTarget.textContent = `${applicant.interview_count}回`
    if (this.hasLastInterviewDateTarget) this.lastInterviewDateTarget.textContent = applicant.last_interview_date || "-"
    if (this.hasNextActionTarget) this.nextActionTarget.textContent = applicant.next_action
    if (this.hasReferralSourceTarget) this.referralSourceTarget.textContent = applicant.referral_source

    // スキル表示
    if (this.hasSkillsTarget) {
      this.skillsTarget.innerHTML = applicant.skills.map(skill =>
        `<span class="px-2 py-1 text-xs font-medium rounded-full bg-blue-100 text-blue-800">${skill}</span>`
      ).join('')
    }

    // アクションボタン表示
    if (this.hasActionButtonsTarget) {
      this.actionButtonsTarget.innerHTML = this.getActionButtons(applicant)
    }
  }

  // ステータスに応じたCSSクラス
  getStatusClass(status) {
    const classes = {
      "アプリ応募": "px-3 py-1 text-sm font-semibold rounded-full bg-gray-100 text-gray-800",
      "アプリ合格": "px-3 py-1 text-sm font-semibold rounded-full bg-blue-100 text-blue-800",
      "アプリ面接": "px-3 py-1 text-sm font-semibold rounded-full bg-yellow-100 text-yellow-800",
      "採用": "px-3 py-1 text-sm font-semibold rounded-full bg-green-100 text-green-800",
      "不合格": "px-3 py-1 text-sm font-semibold rounded-full bg-red-100 text-red-800",
      "保留": "px-3 py-1 text-sm font-semibold rounded-full bg-orange-100 text-orange-800"
    }
    return classes[status] || "px-3 py-1 text-sm font-semibold rounded-full bg-gray-100 text-gray-800"
  }

  // アクションボタンを生成
  getActionButtons(applicant) {
    let buttons = []

    // 合格ボタン（不合格・採用以外）
    if (!["不合格", "採用"].includes(applicant.status)) {
      buttons.push(`
        <button class="px-4 py-2 bg-green-600 text-white rounded-lg hover:bg-green-700 transition text-sm font-medium"
                data-action="click->recruitment-detail#approve">
          合格
        </button>
      `)
    }

    // 面接設定ボタン（アプリ合格のみ）
    if (applicant.status === "アプリ合格") {
      buttons.push(`
        <button class="px-4 py-2 bg-blue-600 text-white rounded-lg hover:bg-blue-700 transition text-sm font-medium"
                data-action="click->recruitment-detail#scheduleInterview">
          面接設定
        </button>
      `)
    }

    // 不合格ボタン（不合格・採用以外）
    if (!["不合格", "採用"].includes(applicant.status)) {
      buttons.push(`
        <button class="px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700 transition text-sm font-medium"
                data-action="click->recruitment-detail#reject">
          不合格
        </button>
      `)
    }

    // 保留ボタン（保留・不合格・採用以外）
    if (!["保留", "不合格", "採用"].includes(applicant.status)) {
      buttons.push(`
        <button class="px-4 py-2 bg-orange-600 text-white rounded-lg hover:bg-orange-700 transition text-sm font-medium"
                data-action="click->recruitment-detail#hold">
          保留
        </button>
      `)
    }

    return buttons.join('')
  }

  // パネル表示
  showPanel() {
    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("translate-x-full")
      this.panelTarget.classList.add("translate-x-0")
    }
  }

  // パネル非表示
  closePanel() {
    if (this.hasPanelTarget) {
      this.panelTarget.classList.remove("translate-x-0")
      this.panelTarget.classList.add("translate-x-full")
    }
  }

  // 合格処理
  approve() {
    const applicant = this.applicantValue
    if (confirm(`${applicant.name}を合格にしますか？`)) {
      console.log("合格処理:", applicant.id)
      alert(`${applicant.name}を合格にしました`)
      this.closePanel()
      // 実際のアプリでは、ここでサーバーにリクエスト送信してページをリロード
    }
  }

  // 不合格処理
  reject() {
    const applicant = this.applicantValue
    const reason = prompt(`${applicant.name}を不合格にします\n理由を入力してください（任意）`)

    if (reason !== null) { // キャンセルされていない場合
      console.log("不合格処理:", applicant.id, "理由:", reason)
      alert(`${applicant.name}を不合格にしました`)
      this.closePanel()
      // 実際のアプリでは、ここでサーバーにリクエスト送信してページをリロード
    }
  }

  // 保留処理
  hold() {
    const applicant = this.applicantValue
    const reason = prompt(`${applicant.name}を保留にします\n理由を入力してください`)

    if (reason && reason.trim() !== "") {
      console.log("保留処理:", applicant.id, "理由:", reason)
      alert(`${applicant.name}を保留にしました`)
      this.closePanel()
      // 実際のアプリでは、ここでサーバーにリクエスト送信してページをリロード
    }
  }

  // 面接設定
  scheduleInterview() {
    const applicant = this.applicantValue
    const date = prompt(`${applicant.name}の面接日時を入力してください\n（例: 2025-12-01 14:00）`)

    if (date && date.trim() !== "") {
      console.log("面接設定:", applicant.id, "日時:", date)
      alert(`${applicant.name}の面接を設定しました\n日時: ${date}`)
      this.closePanel()
      // 実際のアプリでは、ここでサーバーにリクエスト送信してページをリロード
    }
  }

  // 背景クリックで閉じる
  closeOnBackdrop(event) {
    if (event.target === event.currentTarget) {
      this.closePanel()
    }
  }

  // ESCキーで閉じる
  handleKeyup(event) {
    if (event.key === "Escape") {
      this.closePanel()
    }
  }

  initialize() {
    document.addEventListener("keyup", this.handleKeyup.bind(this))
  }

  disconnect() {
    document.removeEventListener("keyup", this.handleKeyup.bind(this))
  }
}
