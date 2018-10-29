$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'teachers') {return}
	teacherInit();
});

function teacherInit(){
	// BEGIN attach Listeners
	
	// END attach Listeners
}

// BEGIN AJAX functions
function getTeacherShow(teacherId){
	
}
// END AJAX functions
