$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'sections') {return}
	sectionInit();
});


function sectionInit(){
	// GET sections
	let sections = []
	$.getJSON('/sections').done(response => {
		// sections = response
		console.log(response)
	})
	// BEGIN Attach listeners
	$(".sections-all-cores-link").click((event) => {
		event.preventDefault();
		$('.sections-content-container')
	})

}

function getMasterSchedule(){
	
}


// li><a class="sections-master-schedule-link" href="#">Master Schedule</a></li>
// 		<li><a class="sections-all-cores-link" href='#'>All Cores</a></li>
// 		<li><a class="sections-non-cores-link" href="#">All Non-Cores</a></li>
// 		<li><a class="sections-departments-link" href='#'>All Departments</a></li>