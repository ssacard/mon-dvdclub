function initPage(){
	var inputs = document.getElementsByTagName('input');
	for (var i=0; i<inputs.length; i++)  {
		if (inputs[i].parentNode.className.indexOf('focus')!=-1)  {
			inputs[i].onfocus = function()
			{
				this.parentNode.className += ' active';
			}
			inputs[i].onblur = function()
			{
				this.parentNode.className = this.parentNode.className.replace(' active','');
			}
		}
	}
	var textareas = document.getElementsByTagName('textarea');
	for (var i=0; i<textareas.length; i++)  {
		if (textareas[i].parentNode.className.indexOf('focus')!=-1)  {
			textareas[i].onfocus = function()
			{
				this.parentNode.className += ' active';
			}
			textareas[i].onblur = function()
			{
				this.parentNode.className = this.parentNode.className.replace(' active','');
			}
		}
	}
	var _divs = document.getElementsByTagName('div');
	for (var i=0; i<_divs.length; i++)  {
		if(_divs[i].className.indexOf('disabled')!=-1) {
			var _disabled_links = _divs[i].getElementsByTagName('a');
			for(j=0;j<_disabled_links.length;j++) {
				_disabled_links[j].onmouseover = function(){
					return false;
				}
				_disabled_links[j].onclick = function(){
					return false;
				}
			}
		}
		if(_divs[i].className.indexOf('bx')!=-1) {
			_divs[i].onmouseover = function(){
				this.className += ' selected-box';
			}
			_divs[i].onmouseout = function(){
				this.className = this.className.replace(' selected-box','');
			}
		}
	}
}

if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage);