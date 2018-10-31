
let defaultColors = {
    	0:"#000000",
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

function createStackedBarGraph(chartCanvas, grade_hash, gradeLevels){
	let labels = [...gradeLevels];
	let dataForN = [];
	let dataForB = [];
	let dataForP = [];
	let dataForM = [];
	let dataForE = [];
	console.log(grade_hash)

	for(let i = 0; i < gradeLevels.length; i++){
		dataForN.push(grade_hash["N"].filter(grade => grade.grade_level === gradeLevels[i]).length)
		dataForB.push(grade_hash["B"].filter(grade => grade.grade_level === gradeLevels[i]).length)
		dataForP.push(grade_hash["P"].filter(grade => grade.grade_level === gradeLevels[i]).length)
		dataForM.push(grade_hash["M"].filter(grade => grade.grade_level === gradeLevels[i]).length)
		dataForE.push(grade_hash["E"].filter(grade => grade.grade_level === gradeLevels[i]).length)
	}
	

	new Chart(chartCanvas, {
	    type: 'bar',
	    data: {
	    	labels: labels,
	    	datasets: [{
               	label: "N",
                backgroundColor: defaultColors[0],
                borderColor: defaultColors[0],
                data: dataForN
            },
            {
               	label: "B",
                backgroundColor: defaultColors[1],
                borderColor: defaultColors[0],
                data: dataForB
            },
            {
               	label: "P",
                backgroundColor: defaultColors[2],
                borderColor: defaultColors[0],
                data: dataForP
            },
            {
               	label: "M",
                backgroundColor: defaultColors[3],
                borderColor: defaultColors[0],
                data: dataForM
            },
	        {
	           	label: "E",
	            backgroundColor: defaultColors[4],
	            borderColor: defaultColors[0],
	            data: dataForE
            }]
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

function createStandardRainbow(){


	let colors = [defaultColors["0"], defaultColors["1"], defaultColors["2"], defaultColors["3"], defaultColors["4"]]

	let datasets = []

	for(let i = 0; i < arguments.length; i++){
		datasets.push({
			backgroundColor: colors,
			data: [
				arguments[i]["N"].length, 
				arguments[i]["B"].length, 
				arguments[i]["P"].length, 
				arguments[i]["M"].length, 
				arguments[i]["E"].length
			] 
		})
	}


	let data = {
		labels: ['N', 'B', 'P', 'M', 'E'],
	    datasets: datasets
	}

	let options = {
		rotation: 1 * Math.PI,
        circumference: 1 * Math.PI
    }
	
	let ctx = $('#standard-data-container')

	new Chart(ctx, {
    type: 'doughnut',
    data: data,
    options: options
});

}


