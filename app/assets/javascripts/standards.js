$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'standards') {return}
	standardInit();
});

function standardInit(){

}


// let datasets = {
// 		years: [],
// 		ND: [],
// 		B: [],
// 		P: [],
// 		M: [],
// 		E: []
// 	}
// 	let dataDiv = $('#standard-data-container')[0];
// 	let standardId = $('#standard-id').data("standard")

// 	$.getJSON(`/standards/${standardId}/all_grades`, function(){
// 		console.log("REquest Sent")
// 	}).done(function(response){
// 		console.log()
// 		datasets["years"].push("All Years");
// 		datasets["ND"].push(response.grades.filter(function(grade){ return grade.grade == "0"}).length);
// 		datasets["B"].push(response.grades.filter(function(grade){ return grade.grade == "1"}).length);
// 		datasets["P"].push(response.grades.filter(function(grade){ return grade.grade == "2"}).length);
// 		datasets["M"].push(response.grades.filter(function(grade){ return grade.grade == "3"}).length);
// 		datasets["E"].push(response.grades.filter(function(grade){ return grade.grade == "4"}).length);
// 		console.log(datasets)
// 		createStackedBarGraph(dataDiv, datasets)
// 	})

	
// 	createStackedBarGraph(dataDiv);
// 	$('.term-select').change(function(event){
// 		let standardId = $(this).data('standard')
// 		let $form = $(this)
		
// 		$.ajax({
// 	        url: `${standardId}/grades_per_term`,
// 	        type: $form.attr('method'),
// 	        dataType: 'json',
// 	        data: $form.serialize(),
// 	        success: function(data) {
// 	        	console.log(data)
// 	                   // createStackedBarChart($dataDiv, data);
// 	                 }
// 	    });
// 	})

// 	$('.course-link').on("click", function(event){
// 		event.preventDefault();
// 		let courseId = $('.course-link').data('courseid')

// 		$.getJSON(`/courses/${courseId}`, function(){
// 		console.log("Request Sent")
// 		}).done(function(response){

// 			function Course(course_name, course_number, standards){
// 				this.course_name = course_name;
//     			this.course_number = course_number;
//     			this.standards = standards;
// 			}
// 			Course.prototype.all_standard_names(){
// 				return this.standards.map(function(standard){ return standard.standard_name})
// 			}

// 			// class Course {
// 			// 	constructor(course_name, course_number, standards){
// 			// 		this.course_name = course_name;
// 	  //   			this.course_number = course_number;
// 	  //   			this.standards = standards;

// 			// 	}
// 			// 	all_standard_names(){
// 			// 		return this.standards.map(function(standard){ return standard.standard_name})
// 			// 	}
// 			// }
// 			let course = new Course(response.course_name, response.course_number, response.standards)
// 			let html = 
// 				`<h1>${course.course_name}</h1>` +
// 				`<h2>${course.course_number}</h2>` +
// 				`<h3> All Standards Associated with this Course</h3>` +
// 				'<ul>';
// 				course.all_standard_names().forEach(function(standard_name){
// 					html += `<li>${standard_name}</li>`
// 				})
// 				html+= "</ul>";

// 			$('.content-container').html(html)
// 		})
// 	})
	