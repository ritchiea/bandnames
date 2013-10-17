// Generated by CoffeeScript 1.6.1
(function() {

  jQuery(function($) {
    var $body, divIt, names;
    names = window.bandnames;
    $body = $('body');
    divIt = function(submission) {
      var div;
      div = "<div class='name-container'>\n  <div class='bandname'>\n  " + submission.name + "\n  </div>\n  <div class='sender'>\n  <p class='bandname-focus'>" + submission.name + "</p>\n  <p class='sender-name'>" + submission.sender + "</p>\n  <p class='time'>" + submission.time + "</p>\n  </div>\n</div>";
      return div;
    };
    names.forEach(function(submission) {
      return $body.append(divIt(submission));
    });
    $(document).on('mouseenter', '.name-container', function(e) {
      return $(this).find('.sender').fadeToggle(100);
    });
    return $(document).on('mouseleave', '.name-container', function(e) {
      return $(this).find('.sender').fadeToggle(100);
    });
  });

}).call(this);