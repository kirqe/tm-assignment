module TasksHelper
  def task_controlls(task)
    status_label = content_tag :span, task.state, class: "label label-#{state_color(task)} state"

    if task.state == 'new'
      aevent = 'start'
      icon = 'fa-play'
    elsif task.state == 'started'
      aevent = 'finish'
      icon = 'fa-check'
    else
      hidden = 'hidden'
    end

    controlls = content_tag :a, class: "label label-default check #{hidden}", data: {id: task.id, aevent: "#{aevent}"} do
                  content_tag :i, '', class: "fa #{icon} fa-fw"
                end

    status_label + " " + controlls
  end

  def state_color(task)
    case task.state
    when "new"
      "info"
    when "started"
      "success"
    when "finished"
      "default"
    end
  end
end
