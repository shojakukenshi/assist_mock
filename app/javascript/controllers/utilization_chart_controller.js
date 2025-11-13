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
            label: '総スタッフ数',
            data: chartData.total,
            backgroundColor: 'rgba(209, 213, 219, 0.7)',
            borderColor: 'rgba(156, 163, 175, 1)',
            borderWidth: 1,
            yAxisID: 'y',
            order: 2
          },
          {
            type: 'bar',
            label: '稼働数',
            data: chartData.active,
            backgroundColor: 'rgba(59, 130, 246, 0.8)',
            borderColor: 'rgba(59, 130, 246, 1)',
            borderWidth: 1,
            yAxisID: 'y',
            order: 1
          },
          {
            type: 'line',
            label: '稼働率',
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
                    label += context.parsed.y + '名'
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
              text: 'スタッフ数 (名)'
            },
            ticks: {
              callback: function(value) {
                return value + '名'
              }
            }
          },
          y1: {
            type: 'linear',
            display: true,
            position: 'right',
            title: {
              display: true,
              text: '稼働率 (%)'
            },
            min: 0,
            max: 100,
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
