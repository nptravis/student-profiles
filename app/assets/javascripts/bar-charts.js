$(document).on('turbolinks:load', function(){
var data_hash = $('#studentshow').data('student');
if (data_hash){
// ////// Iterate through course names to make charts
for(var i = 1; i < data_hash.length; i++){

// /////// Bar Chart //////////////////////////
    var ctx = document.getElementById("barChart" + i);

    var s1_standard_names = Object.keys(data_hash[i].s1_standards)
    var s1_standard_grades = Object.values(data_hash[i].s1_standards)
    var s1_hom_names = Object.keys(data_hash[i].s1_homs)
    var s1_hom_grades = Object.values(data_hash[i].s1_homs)
    var s2_standard_names = Object.keys(data_hash[i].s2_standards)
    var s2_standard_grades = Object.values(data_hash[i].s2_standards)
    var s2_hom_names = Object.keys(data_hash[i].s2_homs)
    var s2_hom_grades = Object.values(data_hash[i].s2_homs)

    var myChart = new Chart(ctx, {
        type: 'horizontalBar',
        data: {
            labels: s1_standard_names,
            datasets: [{
                label: "S1",
                data: s1_standard_grades,
                backgroundColor: 'rgba(255, 99, 132, 0.2)', 
                borderColor: 'rgba(255,99,132,1)',
                borderWidth: 1
            },
            {
                label: "S2",
                data: s2_standard_grades,
                backgroundColor: '#D8ECFA', 
                borderColor: 'rgba(54, 162, 235, 1)',
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
            labels: s1_hom_names,
            datasets: [{
                label: 'S1',
                data: s1_hom_grades,
                backgroundColor: 'rgba(255, 99, 132, 0.2)',
                borderColor: 'rgba(255,99,132,1)',
                borderWidth: 1
            },{
                label: 'S2',
                data: s2_hom_grades,
                backgroundColor: 'rgba(54, 162, 235, 0.2)',
                    
                borderColor: 'rgba(54, 162, 235, 1)',
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
}

});