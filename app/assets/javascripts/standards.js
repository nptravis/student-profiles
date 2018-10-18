$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'standards') {return}
	standardInit();
});



function standardInit(){

	const standardId = $('#standard-data').data("standardid")
	const grade_hash = $('#standard-data').data('grades')
	const chartCanvas = $('#standard-data-container')
	const gradeLevels = $('#standard-data').data('gradelevels')
	createStackedBarGraph(chartCanvas, grade_hash, gradeLevels)
	
}

// BEGIN AJAX Functions

// END AJAX Functions

// BEGIN Operational Functions

// END Operational Functions