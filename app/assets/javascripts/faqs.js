/* 
* @Author: george
* @Date:   2014-03-17 15:15:53
* @Last Modified by:   george
* @Last Modified time: 2014-03-17 23:44:43
*/

function showFaqUsifulMessage(field, text, error){
	var originalText = field.html();

	// show thanks message
	field.stop().animate({"opacity":"0.0"}, 'fast', function(){
		field.html(text);
		if (error) $(this).addClass("text-danger");
		$(this).animate({"opacity":"1.0"}, 'slow', function(){

		}).delay( 3000 ).animate({"opacity":"0.0"}, 'fast', function(){
			field.html(originalText);
			if (error) $(this).removeClass("text-danger");
			$(this).animate({"opacity":"1.0"}, 'fast');
		});
	});
}

function hideFaqUsifulVotingAndShowMessage(field, text){
	var originalText = field.html();

	// show thanks message
	field.stop().animate({"opacity":"0.0"}, 'fast', function(){
		field.html(text);
		field.animate({"opacity":"1.0"}, 'slow');
	});
}

/**
 * Submits the users opinion on the FAQ (useful or not)
 * @param int $faq_id The FAQs ID
 * @param bool $state The state. True = Useful, False = Not Useful
 * @return void
 */
function processUsersOpinionOnFAQ(faq_id, state){

	var requesterField = $("h5", "#collapse-"+faq_id);

    // submit async request
    $.ajax({
        type: "GET",
        url: "questions/" + faq_id + "/useful/" + state,
        dataType:'json',
        beforeSend: function(){
            $(this).unbind('click');
        },
        success: function(data){
            
            // Any problem?
            if(data.failure){
                // Yeap. Let the user send it again
                $(this).bind('click', function(){
                    processUsersOpinionOnFAQ(faq_id, state);
                });

                showFaqUsifulMessage(requesterField, "Something went wrong. Please try again.", true)
            }
            else{
                // no problem
                hideFaqUsifulVotingAndShowMessage(requesterField, data.message);
            }
        },
        error: function(data){
            // Oops. Something went bad.
            $(this).bind('click', function(){
                processUsersOpinionOnFAQ(faq_id, state);
            });

            $(this).html("Something went wrong. Reload and try again.");
        }
    });
}

$(document).ready(function(){
    $("button.useful").on("click", function(){
    	processUsersOpinionOnFAQ($(this).data("question"), $(this).data("state"));
    });
});