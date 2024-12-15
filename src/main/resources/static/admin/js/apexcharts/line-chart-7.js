(function ($) {
  
    var tfLineChart = (function () {
  
      var chartBar = function () {
      
        var options = {
            series: [{
            name: 'Doanh thu',
            type: 'column',
            data: jsonChartMonthlyData.revenueList
          }],
          chart: {
            height: 404,
            type: 'line',
            stacked: false,
            toolbar: {
              show: false,
            },
            animations: {
              enabled: true,
              easing: 'easeinout',
              speed: 10,
              animateGradually: {
                  enabled: true,
                  delay: 10
              },
              dynamicAnimation: {
                  enabled: true,
                  speed: 10
              }
            }
          },
          plotOptions: {
            bar: {
              horizontal: false,
              borderRadius: 5,
              borderRadiusApplication: 'end', // 'around', 'end'
              borderRadiusWhenStacked: 'last', // 'all', 'last'
              columnWidth: '40px'
            }
          },
          dataLabels: {
            enabled: false
          },
          legend: {
            show: false,
          },
          colors: ['#FF7433', '#8F77F3'],
          stroke: {
            width: [0, 3],
            curve: 'smooth'
          },
          xaxis: {
            labels: {
              style: {
                colors: '#95989D',
              },
            },
            tooltip: {
              enabled: false
            },
            categories: jsonChartMonthlyData.monthList
          },
          responsive: [{
            breakpoint: 991,
            options: {
              chart: {
                height: 300
              },
            }
          }],
          yaxis: {
            show: false,
          },
          tooltip: {
            y: {
              title: {
                formatter: function (e) {
                  return e;
                },
              },
            },
          },
        };

        chart = new ApexCharts(
          document.querySelector("#line-chart-7"),
          options
        );
        if ($("#line-chart-7").length > 0) {
          chart.render();
        }
      };
  
      /* Function ============ */
      return {
        load: function () {
          chartBar();
        },
      };
    })();
  
    jQuery(window).on("load", function () {
      tfLineChart.load();
    });
  
})(jQuery);