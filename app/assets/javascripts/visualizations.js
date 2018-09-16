
function createBarGraph(dataDiv, s1_hash, s2_hash) {
	console.log(arguments)
	let notations = {
        0:"ND",
        1:"B",
        2:"P",
        3:"M",
        4:"E"
    }

    let colors = {
    	0:"#FBE2E62",
        1:"#A8271E",
        2:"#F8DA06",
        3:"#249D3D",
        4:"#007CC6"
    }

	let barChartDiv = dataDiv;
	let barChart = new Chart(barChartDiv, {
	    type: 'horizontalBar',
	    data: {
	        labels: Object.keys(s1_hash),
	        datasets: [{
	            label: "S1",
	            data: Object.values(s1_hash),
	            backgroundColor: Object.values(s1_hash).map(function(grade){
	            	return colors[grade]
	            }), 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        },
	        {
	            label: "S2",
	            data: Object.values(s2_hash),
	            backgroundColor: Object.values(s2_hash).map(function(grade){
	            	return colors[grade]
	            }), 
	            borderColor: 'rgba(54, 162, 235, 1)',
	            borderWidth: 1

	        }
	    ]},
	    options: {
	    	responsive: true,
	    	maintainAspectRatio: true,
	        title: {
	            display: true,
	            text: "Standards"
	        },
	        scales: {
	            xAxes: [{
	                ticks:{
	                    beginAtZero: true,
	                    max: 4,
	                    userCallback: function (value, index, values) {
	                        return notations[value];
	                    }
	                }
	            }]
	        },
	        layout: {
	            padding: {
	                left: 2,
	                right: 2,
	                top: 2,
	                bottom: 2
	            }
	        }
	    }
	});
}


function createRadarGraph(dataDiv, s1_hash, s2_hash){
	let notations = {
        0:"ND",
        1:"B",
        2:"P",
        3:"M",
        4:"E"
    }

   let colors = {
    	0:"#FBE2E62",
        1:"#A8271E",
        2:"#F8DA06",
        3:"#249D3D",
        4:"#007CC6"
    }

	let barChartDiv = dataDiv;
	let radarChart = new Chart(radarChartDiv, {
        type: 'radar',
        data: {
            labels: Object.keys(s1_hash),
            datasets: [{
                label: 'S1',
                data: Object.values(s1_hash),
                backgroundColor: 'rgba(255,226,230, .4)',
                borderColor: 'rgba(255,99,132,1)',
                borderWidth: 1
            }
            ,{
                label: 'S2',
                data: Object.values(s2_hash),
                backgroundColor: 'rgba(225, 241, 255, .4)',
                borderColor: 'rgba(54, 162, 235, 1)',
                borderWidth: 1
            }
        ]},
        options: {
            responsive: true,
            title: {
                display: true,
                text: `Habits of Mind`
            },
            maintainAspectRatio: true,
            scale: {
                ticks: {
                    beginAtZero:true,
                    max: 4,
                    userCallback: function (value, index, values) {
                        return notations[value];
                    }
                }
            },
            layout: {
                padding: {
                    left: 2,
                    right: 2,
                    top: 2,
                    bottom: 10
                }
            }
        }
    });   
}
