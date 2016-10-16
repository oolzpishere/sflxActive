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

    if ( $('#ckeditor').length ) 
	CKEDITOR.replace( 'ckeditor' );
    if ( $('#ckeditor').prev('label').length ) 
	$('#ckeditor').prev('label').css('float','none');

    //p initial wave after change page
    Waves.displayEffect();

})
