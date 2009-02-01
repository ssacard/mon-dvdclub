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
}

if (window.addEventListener)
	window.addEventListener("load", initPage, false);
else if (window.attachEvent)
	window.attachEvent("onload", initPage);