var counter_requested;

var _getCounter = function () {
  var $counter = $('#notifly-counter');
  var $notifly = $('#notifly');

  if (!counter_requested) {
    $.ajax({
      url: $counter.data('path'),
      type: 'GET',
      error: _handleError
    });
  }
};


var _handleError = function (data) {
  counter_requested = false;
};

var _refreshCounter = function () {
  var counter_requested_count = 0;

  $('#notifly').click(function () {
    if (counter_requested_count < 1) {
      counter_requested = false;
      counter_requested_count += 1;

      _getCounter();
    };
  });
};

$(document).ready(function() {
  _getCounter();
  _refreshCounter();
});