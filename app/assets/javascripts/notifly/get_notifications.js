var notifications_requested;

var _getNotifications = function () {
  var $notifly = $('#notifly');

  $notifly.hover(function () {
    if (!notifications_requested) {
      notifications_requested = true;

      $.ajax({
        url: $notifly.data('path'),
        type: 'GET',
        error: _handleError
      });
    }
  });
};

var _handleError = function (data) {
  notifications_requested = false;
};

$(document).ready(function() {
  _getNotifications();
});