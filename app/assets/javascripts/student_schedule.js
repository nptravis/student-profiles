function createSchedule(response, studentId){
	
	$('.student-data-container').html(response.show)

	
	let squares = $('.section-box');
	let squares_s2 = $('.section-box-s2');
	let possibleDays = {"A": -1, "B": 6, "C": 13, "D": 20}

	// let randomColor = "hsl(" + 360 * Math.random() + ',' +
 //             (25 + 70 * Math.random()) + '%,' + 
 //             (85 + 10 * Math.random()) + '%)';
	
	let sections = response.current_sections;

	for(let i = 0; i < sections.length;i++){

		randomColor = "hsl(" + 360 * Math.random() + ',' +
         (25 + 70 * Math.random()) + '%,' + 
         (85 + 10 * Math.random()) + '%)';

		let exArray = sections[i].expression.split(' ');

		for(let t = 0; t < exArray.length; t++){

			let period = exArray[t].match(/\d+/g)
			let days = exArray[t].match(/[A-D]/g)
			let multiplier = 0;

			if (exArray[t].match(/[-]/g)){
				let set =["A", "B", "C", "D"]
				let dashDays = exArray[t].match(/\w-\w/g)[0].match(/\w/g);
				let otherDay = exArray[t].match(/\(\w,|,\w\)/g)
				
				if (otherDay === null){
					switch (set.indexOf(dashDays[1]) - set.indexOf(dashDays[0])){
					case 1:
						days = dashDays;
						break;
					case 2:
						days = [...dashDays, set[set.indexOf(dashDays[0]+1)]];
						break;
					case 3:
						days = set
						break;
					}
				} else {
					otherDay = otherDay[0].match(/\w/g);

					switch (set.indexOf(dashDays[1]) - set.indexOf(dashDays[0])){
					case 1:
						days = [...dashDays, ...otherDay];
						break;
					case 2:
						days = [...dashDays, ...otherDay, set[set.indexOf(dashDays[0]+1)]];
						break;
					case 3:
						days = set
						break;
					}
				}

			 

			days.forEach(function(day){
				let html = 
				"<p><small>" + sections[i].course_name + "</small></p>"+
				"<p><small>" + sections[i].course_number + "." + sections[i].section_number + "</small></p>" +
				"<small>Room: " + sections[i].room + "</small>";

				multiplier = possibleDays[day];

				if (sections[i].termid === 2802){

					squares_s2[parseInt(period)+multiplier].innerHTML = html;
					$(squares_s2[parseInt(period)+multiplier]).css('background-color', randomColor);

				} else {
					
					squares[parseInt(period)+multiplier].innerHTML = html;
					$(squares[parseInt(period)+multiplier]).css('background-color', randomColor);
				}

				if (sections[i].termid === 2800){
					$(squares[parseInt(period)+multiplier]).attr('rowspan', "2");
					$(squares_s2[parseInt(period)+multiplier]).remove()

				}

			})
		}			
	}
}
}