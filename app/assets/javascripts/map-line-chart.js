$(document).on('turbolinks:load', function(){
var ctx = document.getElementById('map-chart').getContext('2d');
var chart = new Chart(ctx, {
    // The type of chart we want to create
    type: 'line',

    // The data for our dataset
    data: {
        labels: ["January", "February", "March", "April", "May", "June", "July"],
        datasets: [{
            label: "My First dataset",
            backgroundColor: 'rgb(255, 99, 132)',
            borderColor: 'rgb(255, 99, 132)',
            data: [0, 10, 5, 2, 20, 30, 45],
        },
        {
            label: "My Second dataset",
            backgroundColor: 'rgb(135, 200, 54)',
            borderColor: 'rgb(255, 99, 132)',
            data: [5, 3, 81, 49, 28, 10, 100],
        },
        {
            label: "My Third dataset",
            backgroundColor: 'rgb(45, 89, 255)',
            borderColor: 'rgb(100, 99, 132)',
            data: [100, 98, 91, 97, 95, 99, 100]
        },
        {
            label: "My Student dataset",
            backgroundColor: 'rgb(0, 0, 20)',
            borderColor: 'rgb(23, 23, 23)',
            data: [ 50, 59, 50],
            type: 'bar'
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

});