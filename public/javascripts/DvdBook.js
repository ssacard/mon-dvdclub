var DvdBook = Class.create({ 
  initialize: function( data ){
    this.user = {};
    this.user.id = data[0].session.uid;
    FB.api({ method: 'fql.query', query: "select name, email from user where uid = " + this.user.id }, this.gotInfos.bind( this ));
  },

  gotInfos: function( resp ){
    this.user.email = resp[0].email;
    this.user.name  = resp[0].name;

    new Ajax.Request( window.location.href.replace( /(http?:\/\/.*?\/).*/, '$1' ) + 'facebook_connect?format=json', {
      parameters: 'login=' + this.user.name + '&email=' + this.user.email + '&facebook_id=' + this.user.id,
      onSuccess: this.connected.bind( this )
    });
  },

  connected: function( response ){
    console.log( resp );
    if ( resp.status == 'ok' ){
      window.location.href = window.location.href.replace( /(http?:\/\/.*?\/).*/, '$1' ) + 'home';
    }

    else {
      alert( resp.errors );
    }
  }
});
