$(function () {
    
    // $('#edit_gallery').fileupload({
    //     dataType: 'json',
    //     done: function (e, data) {
    //         $.each(data.result.files, function (index, file) {
    //             $('<p/>').text(file.name).appendTo(document.body);
    //         });
    //         //debugger;
    //     }
    // });

    if ( $('#ckeditor').length ) 
	      CKEDITOR.replace( 'ckeditor' );
    if ( $('#ckeditor').prev('label').length ) 
	      $('#ckeditor').prev('label').css('float','none');

});
