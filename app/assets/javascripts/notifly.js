//= require 'jquery'
//= require 'jquery_ujs'
//= require 'notifly/get_notifications'
//= require 'notifly/seen_notifications'
//= require 'notifly/read_notifications'
//= require 'notifly/more_notifications'
//= require 'twitter/bootstrap'

$(document).ready(function() {
  $(document).on('click', '#notifly-notifications-panel.dropdown-menu', function (e) {
    $('#notifly').hasClass('keep_open') && e.stopPropagation();
  });
});