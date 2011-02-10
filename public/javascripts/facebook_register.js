FB.init({ 
  appId: '184393274916546',
  cookie: true,
  status: true,
  xfbml: true
});

function validate_async( form, cb ){
  new Ajax.Request( window.location.href.replace( /(http?:\/\/.*?\/).*/, '$1' ) + 'facebook_create?format=json', {
    parameters: 'dvd_club_name=' + form.dvd_club_name + '&user_terms=' + form.user_terms,
    onSuccess: function( response ){
      var json = response.responseJSON;
      if ( json.status == 'error' ){
        cb( json.errors );
      }

      else {
        cb();
      }
    }
  });
}
