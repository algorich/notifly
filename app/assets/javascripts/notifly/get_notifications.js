var _getNotifications = function () {
  var $notifly = $('#notifly');
  var id   = $notifly.data('receiver-id');
  var type = $notifly.data('receiver-type');
  requested = false;

  $notifly.hover(function () {
    if (!requested) {
      requested = true;

      $.ajax({
        url: $notifly.data('path'),
        data: { receiver_id: id, receiver_type: type },
        type: 'GET'
      });
    }
  });
};

$(document).ready(function() {
  _getNotifications();
});