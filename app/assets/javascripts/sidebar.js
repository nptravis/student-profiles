$(document).on("turbolinks:load", function(){
	let toggle = true
	if (window.location.pathname == '/sections') {
		toggle = false
	}

	$('.hide-sidebar').on("click", () => {
		let $sidebar = $('.sidebar-container')
		toggle ? $sidebar.hide() : $sidebar.show();
		toggle = !toggle
		
	})

});
