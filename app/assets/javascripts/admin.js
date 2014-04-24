/* 
* @Author: george
* @Date:   2014-03-20 10:24:43
* @Last Modified by:   george
* @Last Modified time: 2014-03-20 16:09:26
*/

/**
 * Gets a random quote from a thirdparty webservice
 * @param obj $field The field that will receive the content
 * @return void
 */
function getRandomQuote(field){

	if(field.length){

		$.ajax({
		    url: "http://query.yahooapis.com/v1/public/yql",

		    // the name of the callback parameter, as specified by the YQL service
		    jsonp: "callback",

		    // tell jQuery we're expecting JSONP
		    dataType: "jsonp",

		    // tell YQL what we want and that we want JSON
		    data: {
		        q: "select * from json where url=\"http://www.iheartquotes.com/api/v1/random?format=json&source=esr+humorix_misc+humorix_stories+joel_on_software+macintosh+math+mav_flame+osp_rules+paul_graham+prog_style+subversion&max_lines=2&show_permalink=0&show_source=0\"",
		        format: "json"
		    },

		    // work with the response

	        beforeSend: function(){
	            
	        },
	        success: function(data){
	            field.html(data.query.results.json.quote);
	        },
	        error: function(data){
	            // Oops. Something went bad.
	            // Display a graceful message
	           field.html("Sorry. No quotes today. - Sysadmin.");
	        }
		});
	}
	else{
		console.log("getRandomQuote error: HTML field not found.");
	}
}

$(document).ready(function(){
	if ($("body.login").length)
    	getRandomQuote($("#quote"));
});