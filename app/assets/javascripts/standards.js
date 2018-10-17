$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'standards') {return}
	standardInit();
});



function standardInit(){

	const standardId = $('#standard-data').data("standardid")
	const grade_hash = $('#standard-data').data('grades')
	
	createStandardRainbow(grade_hash)

	// $(".standard-show-filter").on('submit', function(event) {
	// 	event.preventDefault();
	// 	let termId = $('#Year option:selected').val();
	// 	let gradeLevels = $('#Grade_Level option:selected').val();
	// 	getAllGrades(termId, gradeLevels, standardId)
	// 	return false;
	// })

	$('.gradelevel-button').on("click", function(event){

		let dataSet = {
			E: grade_hash["E"].filter(grade => grade.grade_level === this.value),
			M: grade_hash["M"].filter(grade => grade.grade_level === this.value),
			P: grade_hash["P"].filter(grade => grade.grade_level === this.value),
			B: grade_hash["B"].filter(grade => grade.grade_level === this.value),
			N: grade_hash["N"].filter(grade => grade.grade_level === this.value)
		}
		createStandardRainbow(grade_hash, dataSet)
	})
}

// BEGIN AJAX Functions

// END AJAX Functions

// BEGIN Operational Functions

// END Operational Functions