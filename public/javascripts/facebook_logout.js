document.observe( "dom:loaded", function(){ 
  var $logout = $$( '#header .logout_fb' )[0];
  if ( $logout ){
    $logout.observe( 'click', function( event ){
      event.stop();
      var $target = $( event.target );

      FB.Connect.logout( function(){
        window.location.href = $target.href;
      });
    });
  }
});
