module TasksHelper
  def task_controlls(task)
    status_label = content_tag :span, task.state, class: "label label-#{state_color(task)} state"

    controlls = content_tag :span do
                  if task.state == 'new'
                    aasm_event = 'start'
                    icon = 'fa-play'
                    hidden = 'visible'
                  elsif task.state == 'started'
                    aasm_event = 'finish'
                    icon = 'fa-check'
                    hidden = 'visible'
                  else
                    hidden = 'hidden'
                  end
                  content_tag :span, class: "label label-default check #{hidden}", data: {id: task.id, aasm_event: "#{aasm_event}"} do
                    content_tag :i, '', class: "fa #{icon} fa-fw"
                  end
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
