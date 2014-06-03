/*
* @Author: george
* @Date:   2014-02-27 16:55:31
* @Last Modified by:   george
* @Last Modified time: 2014-03-24 21:54:32
*/
var menuRespOpen=true;
( function() {
    $( function() {

    	$('.icon_resp > a ').click(function(){
    		if(menuRespOpen){
    			 $("#footer_holder_resp").animate({height:'352px'},200);
    			 $('.icon_resp i').css('color','#fff')
    			 menuRespOpen=false;
    		}else{
    			 $("#footer_holder_resp").animate({height:'50px'},200);
    			 $('.icon_resp i').css('color','#f9da03')
    			 menuRespOpen=true;
    		}
    		return false;
    	} );

    } );
} )( jQuery );