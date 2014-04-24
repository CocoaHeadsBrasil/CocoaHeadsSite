function showMessage(text, error){
	var originalText = $("#newsletter a").html();

	// show thanks message
	$("#newsletter").stop().animate({"opacity":"0.0"}, 'fast', function(){
		$("#newsletter a").html(text);
		if (error) $(this).addClass("error");
		$(this).animate({"opacity":"1.0"}, 'slow', function(){

		}).delay( 3000 ).animate({"opacity":"0.0"}, 'fast', function(){
			$("#newsletter a").html(originalText);
			if (error) $(this).removeClass("error");
			$(this).animate({"opacity":"1.0"}, 'fast');
		});
	});
}

$(document).ready(function(){

	$('#subscription_form')
	.bind("ajax:beforeSend", function(evt, xhr, settings){
		var $submitButton = $(this).find('input[name="commit"]');
		var $form = $(this);

		// Update the text of the submit button to let the user know stuff is happening.
		// But first, store the original text of the submit button, so it can be restored when the request is finished.
		$submitButton.data( 'origText', $(this).text() );
		$submitButton.text( "Adding you..." );

		// clean any previous error
		$form.find('span').addClass("hide");
		$form.find("div.form-group").removeClass("has-error");
	})
	.bind("ajax:success", function(evt, data, status, xhr){
		var $form = $(this);

		// Reset fields and any validation errors, so form can be used again, but leave hidden_field values intact.
		$form.find('textarea,input[type="text"],input[type="file"]').val("");
		// toggle subscription box back.
		$("#subscription").subscription('toggle');
		// show thanks message
		showMessage("Thank you! See you soon.");
	})
	.bind('ajax:complete', function(evt, xhr, status){
		var $submitButton = $(this).find('input[name="commit"]');

		// Restore the original submit button text
		$submitButton.text( $(this).data('origText') );
	})
	.bind("ajax:error", function(evt, xhr, status, error){
		var $form = $(this), errors, errorText;

		try {
			// Populate errorText with the comment errors
			errors = $.parseJSON(xhr.responseText);
		} catch(err) {
			// If the responseText is not valid JSON (like if a 500 exception was thrown), populate errors with a generic error message.
			errors = {message: "Please reload the page and try again"};
		}

		// mark all the problematic fields as errors
		$.each(errors, function(index, value) {
			var parentElement = $("#"+index).parent(".form-group");
			parentElement.addClass("has-error has-feedback");
			$("span", parentElement).removeClass("hide");
		});

		// display a full error message
		// for only the first field due space constraints
		if (Object.keys(errors).length > 1){
			showMessage("All fields are required", true);
		}
		else{
			$.each(errors, function(index, value) {
				showMessage(value[0], true);
				return false;
			});			
		}
	});

});