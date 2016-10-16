$(document).on('turbolinks:load', function() {

    // $('#gallery_images_attributes_0_image').fileupload();

    // Initialize collapse button
    $('.button-collapse').sideNav({
	menuWidth: 240, // Default is 240
	edge: 'left', // Choose the horizontal origin
	closeOnClick: true // Closes side-nav on <a> clicks, useful for Angular/Meteor
    });

    // $(window).on("resize", function() {
    // });

    $('.dropdown-button').dropdown({
	constrain_width: true, // Does not change width of dropdown to that of the activator
	hover: true, // Activate on hover
	gutter: 0, // Spacing from edge
	belowOrigin: true // Displays dropdown below the button
    });

    if ( $('#ckeditor').length ) 
	CKEDITOR.replace( 'ckeditor' );
    if ( $('#ckeditor').prev('label').length ) 
	$('#ckeditor').prev('label').css('float','none');

    //p initial wave after change page
    Waves.displayEffect();

})
