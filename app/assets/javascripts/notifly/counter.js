
var _getCounter = function () {
  var $counter = $('#notifly-counter');
  var id   = $counter.data('receiver-id');
  var type = $counter.data('receiver-type');

  $.ajax({
    url: $counter.data('path'),
    data: { receiver_id: id, receiver_type: type },
    type: 'GET'
  });
};

$(document).ready(function() {
  _getCounter();
});