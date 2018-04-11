$(document).ready(function(){

var student_object = $('#studentshow').data('student');
console.log(student_object)

google.charts.load('current', {'packages':['corechart']});
google.charts.setOnLoadCallback(drawChart);

function drawChart() {

      // Create the data table.
      var data = new google.visualization.DataTable();
      
      data.addColumn('string', 'Standard');
      data.addColumn('number', 'Grade');
      data.addRows(student_object.standards);

      // Set chart options
      var options = {'title':'Standards',
                     'width':1400,
                     'height':2000};

      // Instantiate and draw our chart, passing in some options.
      var chart = new google.visualization.BarChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    } 
});  
