
var _getCounter = function () {
  var $counter = $('#notifly-counter');
  var $notifly = $('#notifly');
  var id   = $notifly.data('receiver-id');
  var type = $notifly.data('receiver-type');

  $.ajax({
    url: $counter.data('path'),
    data: { receiver_id: id, receiver_type: type },
    type: 'GET'
  });
};

$(document).ready(function() {
  _getCounter();
});