var _getCounter = function () {
  var $counter = $('#notifly-counter');
  var $notifly = $('#notifly');
  requested = false;

  if (!requested) {
    $.ajax({
      url: $counter.data('path'),
      type: 'GET',
      error: _handleError
    });
  }
};

var _refreshCounter = function () {
  requested = false;

  $('#notifly').click(function () {
    _getCounter();
  });
};

var _handleError = function (data) {
  requested = false;
};

$(document).ready(function() {
  _getCounter();
  _refreshCounter();
});