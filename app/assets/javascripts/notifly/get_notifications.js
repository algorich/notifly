var _getNotifications = function () {
  var $notifly = $('#notifly');
  requested = false;

  $notifly.hover(function () {
    if (!requested) {
      requested = true;

      $.ajax({
        url: $notifly.data('path'),
        type: 'GET',
        error: _handleError
      });
    }
  });
};

var _handleError = function (data) {
  requested = false;
};

$(document).ready(function() {
  _getNotifications();
});