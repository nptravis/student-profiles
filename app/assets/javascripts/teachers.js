$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'teachers') {return}
	teacherInit();
});

function teacherInit(){
	// BEGIN attach Listeners
	$('.teacher-link').on("click", function(event){
		event.preventDefault();
		let teacherId = $(this).data('teacher')
		getTeacherShow(teacherId);
	})
	// END attach Listeners
}


// BEGIN AJAX functions
function getTeacherShow(teacherId){
	$.getJSON(`/teachers/${teacherId}`, function(response){
		$('.teacher-info').html(response.show + response.current_sections);
	})
}
// END AJAX functions
