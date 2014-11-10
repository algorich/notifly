
var _getCounter = function () {
  var $counter = $('#notifly-counter');
  var $notifly = $('#notifly');

  $.ajax({
    url: $counter.data('path'),
    type: 'GET'
  });
};

$(document).ready(function() {
  _getCounter();
});