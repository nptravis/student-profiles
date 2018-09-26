
let defaultColors = {
    	0:"#FBE2E62",
        1:"#A8271E",
        2:"#F8DA06",
        3:"#249D3D",
        4:"#007CC6"
    }


function createBarGraph(dataDiv, s1_hash, s2_hash) {
	
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

function createStackedBarGraph(){

	let datasets = {
		years: [],
		ND: [],
		B: [],
		P: [],
		M: [],
		E: []
	}
	if (arguments){
		for(let i = 1; i < arguments.length; i++){

			datasets["years"].push(arguments[i]["years"]);
			datasets["ND"].push(arguments[i]["ND"]);
			datasets["B"].push(arguments[i]["B"]);
			datasets["M"].push(arguments[i]["M"]);
			datasets["P"].push(arguments[i]["P"]);
			datasets["E"].push(arguments[i]["E"]);
		}
	}
	

	var stackedBar = new Chart(arguments[0], {
	    type: 'bar',
	    data: {
	    	labels: datasets["years"],
	    	datasets: [{
	            label: "ND",
	            data: datasets["ND"],
	            backgroundColor: defaultColors[0], 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        },
	        {
	            label: "B",
	            data: datasets["B"],
	            backgroundColor: defaultColors[1], 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        },
	        {
	            label: "P",
	            data: datasets["P"],
	            backgroundColor: defaultColors[2], 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        },
	        {
	            label: "M",
	            data: datasets["M"],
	            backgroundColor: defaultColors[3], 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        },
	        {
	            label: "E",
	            data: datasets["E"],
	            backgroundColor: defaultColors[4], 
	            borderColor: 'rgba(255,99,132,1)',
	            borderWidth: 1
	        }],

	    },
	    options: {
	        scales: {
	            xAxes: [{
	                stacked: true
	            }],
	            yAxes: [{
	                stacked: true
	            }]
	        }
	    }
	});
}

function createMapGraph(response){
		$('.student-data-container').html('<canvas id="map-chart-div" ></canvas>')
		let dataDiv = $('#map-chart-div')[0]
        var chart = new Chart(dataDiv, {
            // The type of chart we want to create
            type: 'line',

            // The data for our dataset
            data: {
                labels: ["January", "February", "March", "April", "May", "June", "July"],
                datasets: [{
                    label: "My First dataset",
                    backgroundColor: defaultColors[1],
                    borderColor: defaultColors[0],
                    data: [0, 10, 5, 15, 20, 30, 45],
                },
                {
                    label: "My Second dataset",
                    backgroundColor: defaultColors[2],
                    borderColor: defaultColors[0],
                    data: [5, 3, 34, 49, 87, 92, 100],
                },
                {
                    label: "My Third dataset",
                    backgroundColor: defaultColors[3],
                    borderColor: defaultColors[0],
                    data: [100, 98, 67, 82, 95, 104, 150]
                },
                {
                    label: "My Student dataset",
                    backgroundColor: defaultColors[4],
                    borderColor: defaultColors[0],
                    data: [250, 250, 250, 250, 250, 250, 250]
                }]

            },

            // Configuration options go here
            options: {
                scales: {
                    yAxes: [{
                        stacked: true
                    }]
                }
            }
        });
}