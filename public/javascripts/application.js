MonDVD = {}
MonDVD.Form = {
  submit: function(element) {
    var form = element.up('form');
    if (form.onsubmit) {
      form.onsubmit();
    }
    else {
      form.submit();  
    }
    return false;
  }
}

MonDVD.Search = {
  initialized:false,
  
  initMouseEvent: function() {
    if (MonDVD.Search.initialized)
      return;
    MonDVD.Search.initialized = true;  
    
    var box = $('search-results');
    
    box.observe('mouseover', function(event) {
      var element = event.element().up('.bx');
      if (element)
        element.addClassName('selected-box');
    })
    box.observe('mouseout', function(event) {
      var element = event.element().up('.bx');
      if (element)
        element.removeClassName('selected-box');
    })
  }
}