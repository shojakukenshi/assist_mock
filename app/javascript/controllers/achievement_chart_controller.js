import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    data: Object
  }

  connect() {
    // Chart.jsが読み込まれるまで待機
    if (typeof Chart !== 'undefined') {
      this.initChart()
    } else {
      // Chart.jsの読み込みを待つ
      const checkChart = setInterval(() => {
        if (typeof Chart !== 'undefined') {
          clearInterval(checkChart)
          this.initChart()
        }
      }, 100)
    }
  }

  disconnect() {
    if (this.chart) {
      this.chart.destroy()
    }
  }

  initChart() {
    const ctx = this.element.getContext('2d')
    const chartData = this.dataValue

    this.chart = new Chart(ctx, {
      type: 'bar',
      data: {
        labels: chartData.labels,
        datasets: [
          {
            type: 'bar',
            label: '実績',
            data: chartData.actual,
            backgroundColor: 'rgba(59, 130, 246, 0.8)',
            borderColor: 'rgba(59, 130, 246, 1)',
            borderWidth: 1,
            yAxisID: 'y'
          },
          {
            type: 'bar',
            label: '目標',
            data: chartData.target,
            backgroundColor: 'rgba(209, 213, 219, 0.5)',
            borderColor: 'rgba(156, 163, 175, 1)',
            borderWidth: 1,
            yAxisID: 'y'
          },
          {
            type: 'line',
            label: '達成率',
            data: chartData.rate,
            borderColor: 'rgba(16, 185, 129, 1)',
            backgroundColor: 'rgba(16, 185, 129, 0.1)',
            borderWidth: 3,
            fill: false,
            yAxisID: 'y1',
            tension: 0.3,
            pointRadius: 5,
            pointBackgroundColor: 'rgba(16, 185, 129, 1)',
            pointBorderColor: '#fff',
            pointBorderWidth: 2,
            pointHoverRadius: 7
          }
        ]
      },
      options: {
        responsive: true,
        maintainAspectRatio: false,
        interaction: {
          mode: 'index',
          intersect: false
        },
        plugins: {
          legend: {
            display: true,
            position: 'top'
          },
          tooltip: {
            callbacks: {
              label: function(context) {
                let label = context.dataset.label || ''
                if (label) {
                  label += ': '
                }
                if (context.parsed.y !== null) {
                  if (context.dataset.yAxisID === 'y1') {
                    label += context.parsed.y + '%'
                  } else {
                    label += '¥' + context.parsed.y.toLocaleString()
                  }
                }
                return label
              }
            }
          }
        },
        scales: {
          y: {
            type: 'linear',
            display: true,
            position: 'left',
            title: {
              display: true,
              text: '金額 (万円)'
            },
            ticks: {
              callback: function(value) {
                return '¥' + value.toLocaleString()
              }
            }
          },
          y1: {
            type: 'linear',
            display: true,
            position: 'right',
            title: {
              display: true,
              text: '達成率 (%)'
            },
            min: 0,
            max: 120,
            ticks: {
              callback: function(value) {
                return value + '%'
              }
            },
            grid: {
              drawOnChartArea: false
            }
          }
        }
      }
    })
  }
}
