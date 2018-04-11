$(document).on('turbolinks:load', function(){
var data_hash = $('#studentshow').data('student');
var ctx = document.getElementById("barChart");
ctx.height = 500;

var myChart = new Chart(ctx, {
    type: 'horizontalBar',
    data: {
        labels: data_hash.standard_names,
        datasets: [{
            label: 'Score',
            data: data_hash.standard_grades,
            backgroundColor: 'rgba(255, 99, 132, 0.2)', 
            borderColor: 'rgba(255,99,132,1)',
            borderWidth: 1
        }]
    },
    options: {
        scales: {
            xAxes: [{
                ticks:{
                    callback: function(value, index, values) {
                        switch(value) {
                            case 0:
                            return 'ND';
                            case 1:
                            return 'B';
                            case 2:
                            return 'P';
                            case 3:
                            return 'M';
                            case 4:
                            return 'E';
                        }
                    }
                }
            
            }]
            
        }
        
    }
});

});