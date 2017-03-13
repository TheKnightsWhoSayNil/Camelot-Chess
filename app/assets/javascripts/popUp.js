$(document).ready(function() {
  $('.forfeit').click(function() {
    if (!confirm('Are you sure that you want to end this game?')) {
      return false;
    }
  });
});