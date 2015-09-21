document.onkeydown = function(evt) {
  evt = evt || window.event;
  if (evt.ctrlKey && evt.keyCode == 69 /* e */) {
    document.getElementById('js-edit').style.display = 'block';
  }
};
