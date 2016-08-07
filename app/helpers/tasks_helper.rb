module TasksHelper
  def task_controlls(task)
    status_label = content_tag :span, task.state, class: "label label-#{state_color(task)}"

    controlls = content_tag :span do
                  if task.state == 'new'
                    content_tag :span, class: 'label label-default check', data: {id: task.id, aasm_event: 'start'} do
                      content_tag :i, '', class: 'fa fa-play fa-fw'
                    end
                  elsif task.state == 'started'
                    content_tag :span, class: 'label label-default check', data: {id: task.id, aasm_event: 'finish'} do
                      content_tag :i, '', class: 'fa fa-check fa-fw'
                    end
                  else
                    content_tag :span, ''
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
