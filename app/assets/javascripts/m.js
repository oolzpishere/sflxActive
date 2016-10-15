$(document).on('turbolinks:load', function() {

    // $('#gallery_images_attributes_0_image').fileupload();

    if ( $('#ckeditor').length ) 
	CKEDITOR.replace( 'ckeditor' );
    if ( $('#ckeditor').prev('label').length ) 
	$('#ckeditor').prev('label').css('float','none');

    //p initial wave after change page
    Waves.displayEffect();

})
