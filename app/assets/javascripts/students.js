$(document).on("turbolinks:load", function(){
	if ($('body').data('controller') != 'students') {return}
	studentInit();
});

function studentInit(){
		console.log("init called")
		let studentId = $('.student-show-container').attr("data");

		drawDonutGraphs();

		// BEGIN Attach Listeners
		$('.student-comment-form').on('submit', function(event){
			event.preventDefault();
			postStudentComment(event);
			return false;
		});

		$('.schedule-matrix-link').on("click", function(event){
			event.preventDefault();
			getStudentSchedule(studentId);	
		});

		$('.student-map-link').on("click", function(event){
			event.preventDefault();
			getStudentMap(studentId);
		});

		$('.student-sections-link').on("click", function(event){
			event.preventDefault();
			getStudentSections(studentId);
		});

		$('.student-comments-link').on("click", function(event){
			event.preventDefault();
			getStudentComments(studentId);
			
		})
		// END Attach Listeners

	}

// BEGIN Draw Donut Graphs
function drawDonutGraphs(){
	
	let all_homs = $('#studentshow').data('homs');
	let all_standards = $('#studentshow').data('standards');
	let ND = all_homs.filter(function(grade){return grade.grade === "0"}).length
	let B = all_homs.filter(function(grade){return grade.grade === "1"}).length
	let P = all_homs.filter(function(grade){return grade.grade === "2"}).length
	let M = all_homs.filter(function(grade){return grade.grade === "3"}).length
	let E = all_homs.filter(function(grade){return grade.grade === "4"}).length

	let NDs = all_standards.filter(function(grade){return grade.grade === "0"}).length
	let Bs = all_standards.filter(function(grade){return grade.grade === "1"}).length
	let Ps = all_standards.filter(function(grade){return grade.grade === "2"}).length
	let Ms = all_standards.filter(function(grade){return grade.grade === "3"}).length
	let Es = all_standards.filter(function(grade){return grade.grade === "4"}).length

	let colors = {
    	0:"#FBE2E62",
        1:"#A8271E",
        2:"#F8DA06",
        3:"#249D3D",
        4:"#007CC6"
    }
	
	// BEGIN Doughnut Standards 
	let doughnutDiv = $('#student-doughnut-standards');
	let dataS = {
		    datasets: [{
		        data: [NDs, Bs, Ps, Ms, Es],
		        label: "S1",
                backgroundColor: ['#FBE2E62','#A8271E', '#F8DA06', '#249D3D','#007CC6'], 
                borderColor: '#FFFFFF',
                borderWidth: 1
		    }],

		    // These labels appear in the legend and in the tooltips when hovering different arcs
		    labels: ['ND','B','P','M','E']
		};

	let doughnutChart = new Chart(doughnutDiv, {
	    type: 'doughnut',
	    data: dataS,
	    options: {
	    	legend: {
	    		position: 'right',
	    		display: true
	    	},
	    	title: {
	    		display: true,
	    		text: `Academic Standards (${all_standards.length})`,
	    		position: 'top'
	    	}

	    }
	});
	// END Standards Donut 

	// BEGIN HOMs Donut 
	let homsDoughnutDiv = $('#student-doughnut-homs');
	let data = {
		    datasets: [{
		        data: [ND, B, P, M, E],
		        label: "S1",
                backgroundColor: ['#FBE2E62','#A8271E', '#F8DA06', '#249D3D','#007CC6'], 
                borderColor: '#FFFFFF',
                borderWidth: 1
		    }],

		    // These labels appear in the legend and in the tooltips when hovering different arcs
		    labels: ['ND','B','P','M','E']
		};

	let homsDoughnutChart = new Chart(homsDoughnutDiv, {
	    type: 'doughnut',
	    data: data,
	    options: {
	    	legend: {
	    		position: 'right',
	    		display: false
	    	},
	    	title: {
	    		display: true,
	    		text: `Habits of Mind (${all_homs.length})`,
	    		position: 'top'
	    	}

	    }
	});

	// END HOMs Donut 
}
// END Draw Donut Graphs

function drawSectionGraphs(){
	let data_hash = $('.data-div').data('hash')

    let course_name = data_hash[0]["course_name"];
    let course_number = data_hash[0]["course_number"];
    let section_number = data_hash[0]["section_number"];
    let expression = data_hash[0]["expression"];
    let teacher_email = data_hash[0]["teacher_email"];
    let teacher_name = data_hash[0]["teacher_name"];
    let comments = data_hash[0]["comments"];


     let html = 
        `<h2>${course_name}</h2>` +
        `<h4>${course_number}.${section_number} - ${expression}</h4>` +
        `<p>${teacher_name}</p>` +
        `<p><a href="mailto:${teacher_email}" target="_blank">${teacher_email}</a></p>` +
        '<div class="canvas-wrapper"><div class="canvas-1"><canvas id="barChartDiv"></div></canvas><div class="canvas-2"><canvas id="radarChartDiv"></canvas></div></div>';

    comments.forEach(function(comment){
        let i = 1;
        if (comment != null){
         html += `<a href="" class="trigger_popup_fricc" data-comment="${comment}">S${i} Comment</a>`
         i++;
        }
    })

        $('.student-data-container').html(html)
}
        
// BEGIN student comment popup 
function attachCommentPopupListeners(){

    $(".trigger_popup_fricc.S1").click(function(e){
        e.preventDefault();
        $('.hover_bkgr_fricc.S1').show();
    });

    $(".trigger_popup_fricc.S2").click(function(e){
        e.preventDefault();
        $('.hover_bkgr_fricc.S2').show();
    });

    $('.hover_bkgr_fricc').click(function(){
        $('.hover_bkgr_fricc').hide();
    });

    $('.popupCloseButton').click(function(){
        $('.hover_bkgr_fricc').hide();
    });
}
// END student comment popup 

// BEGIN Create Charts
function drawSectionCharts(){
    let barChartDiv = $('#barChartDiv');
    let radarChartDiv = $('#radarChartDiv');
    let s1Grades = $('.student-section-grades').data("s1")
    let s2Grades = $('.student-section-grades').data("s2")
   	console.log(s1Grades.homs)
    createBarGraph(barChartDiv, s1Grades.standards, s2Grades.standards );
    createRadarGraph(radarChartDiv, s1Grades.homs, s2Grades.homs );
}
 // END Create Charts



// BEGIN Ajax Functions
function postStudentComment(event){

		let $form = $(event.target)
		
		$.ajax( {
	      type: "POST",
	      dataType: 'json',
	      url: $form.attr( 'action' ),
	      data: $form.serialize(),
	      success: function(response) {
	      	let studentId = response.student.id
	      	let username = response.user.username
	      	let content = response.content
	      	let commentId = response.id

	        let html = 
	        '<div class="comment-content">' +
	        	`<a href="/students/${studentId}/comments/${commentId}" data-method="delete" class="destroy"><i class="fas fa-trash-alt"></i></a>` +
	        	`<a href="/students/${studentId}/comments/${commentId}" ><i class="fas fa-pencil-alt"></i></a>` +
	        	`<p class="commentContent">${content} - <small class="commentUsername"><strong>${username}</strong></small></p>` +
	        '</div>'
	        ;
			
	        $('.comments-container').append(html)
	        attachDeleteListener();
	      }
	    } );
}

function attachDeleteListener(){
	$('.destroy').on("click", function(event){
		event.preventDefault();
		event.stopPropagation();
		let $link = $(this)
		$link.parent().hide();

		$.ajax({
			url: $link.attr('href'),
			type: $link.data('method'),
			dataType: 'js',
			success: function(response){
				console.log("Success", response)

			}
		})
		return false;
	})
}

function getStudentSchedule(studentId){
	$.get(`/students/${studentId}/schedule`, function(response){
		// sends to function in student_schedule.js
		createSchedule(response, studentId);
	})
}

function getStudentMap(studentId){
	$.get(`/students/${studentId}/map`, function(response){
		createMapGraph(response, studentId);
	})
}

function getStudentSections(studentId){
	$.get(`/students/${studentId}/sections`, function(response){ 
			$('.student-data-container').html(response)
		}).done(function(){
				attachSectionLinkListener(studentId);
			})
}

function getStudentComments(studentId){
	$.get(`/students/${studentId}/comments`, function(response){
		$('.student-data-container').html(response);
	}).done(function(){
		init();
	})

}

function attachSectionLinkListener(studentId){
	$('.student-section-link').on("click", function(event){
		event.preventDefault();
		let sectionId = $(this).attr('id')
		$.get(`/students/${studentId}/sections/${sectionId}`, function(response){
			$('.student-data-container').html(response)
			attachCommentPopupListeners();
			drawSectionCharts();
		})
	});
}
// END Ajax Functions