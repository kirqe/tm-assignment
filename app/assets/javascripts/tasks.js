// refactor this -_-

var markStarted = function(task){
  var task_id = task.data("id")
  var aevent = task.data("aevent");
  $.ajax({
    type: 'PUT',
    url: '/tasks/' + task_id + "/" + aevent,
    dataType: 'json',
    success: function(data){
      task.closest("tr").removeClass('info').addClass('success');
      task.closest("td").find(".state").text("started").removeClass("label-info").addClass("label-success");
      task.find('i').removeClass('fa-play').addClass('fa-check');
      task.data("aevent", "finish");
    }
  });
}
var markFinished = function(task){
  var task_id = task.data("id")
  var aevent = task.data("aevent");
  $.ajax({
    type: 'PUT',
    url: '/tasks/' + task_id + "/" + aevent,
    dataType: 'json',
    success: function(data){
      task.closest("tr").removeClass('success').addClass('default');
      task.closest("td").find(".state").text("finished").removeClass("label-success").addClass("label-default");
      task.fadeOut();
    }
  });
}

$(document).on("turbolinks:load", function(){
  $(function() {
    $(".check").on("click", function() {
      var task = $(this);
      var aevent = task.data("aevent");

      if (aevent == "start"){
        return markStarted(task);
      }else if (aevent == "finish") {
        return markFinished(task);
      }
    });
  });
});
