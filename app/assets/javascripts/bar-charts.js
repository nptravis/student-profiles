$(document).on('turbolinks:load', function(){
var data_hash = $('#studentshow').data('student');

// ////// Iterate through course names to make charts
for(var i = 1; i < data_hash.length; i++){

// /////// Bar Chart //////////////////////////
    var ctx = document.getElementById("barChart" + i);
    // ctx.height = 100;
    // ctx.width = 400;

    var standard_names = Object.keys(data_hash[i].standards)
    var standard_grades = Object.values(data_hash[i].standards)
    var hom_names = Object.keys(data_hash[i].homs)
    var hom_grades = Object.values(data_hash[i].homs)

    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: standard_names,
            datasets: [{
                label: "Standards",
                data: standard_grades,
                backgroundColor: 'rgba(255, 99, 132, 0.2)', 
                borderColor: 'rgba(255,99,132,1)',
                borderWidth: 1
            }]
        },
        options: {
            title: {
                display: true,
                text: data_hash[i].course_name
            },
            scales: {
                xAxes: [{
                    ticks:{
                        beginAtZero: true,
                        max: 4,
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

// /////// Radar Chart //////////////////////////
    var notations = {
        0:"ND",
        0.5:"",
        1:"B",
        1.5:"",
        2:"P",
        2.5:"",
        3:"M",
        3.5:"",
        4:"E"
    }
    var ctx = document.getElementById("radarChart" + i).getContext('2d');
    var myChart = new Chart(ctx, {
        type: 'radar',
        data: {
            labels: hom_names,
            datasets: [{
                label: 'Habits of Mind',
                data: hom_grades,
                backgroundColor: [
                    'rgba(54, 162, 235, 0.2)',
                    'rgba(255, 206, 86, 0.2)',
                    'rgba(75, 192, 192, 0.2)',
                    'rgba(153, 102, 255, 0.2)',
                    'rgba(255, 159, 64, 0.2)'
                ],
                borderColor: [
                    'rgba(54, 162, 235, 1)',
                    'rgba(255, 206, 86, 1)',
                    'rgba(75, 192, 192, 1)',
                    'rgba(153, 102, 255, 1)',
                    'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scale: {
                ticks: {
                    beginAtZero:true,
                    max: 4,
                    userCallback: function (value, index, values) {
                        return notations[value];
                    }
                }
            }

        }
    });


}

});