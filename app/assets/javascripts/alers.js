$(document).on("turbolinks:load", function(){
  $(function() {
    window.setTimeout(function(){
      $('.sl').fadeOut(500, function(){
        $(this).remove();
      })
    }, 3000)
  });
});
