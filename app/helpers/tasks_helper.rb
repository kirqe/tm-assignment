module TasksHelper
  def state(task)
    case task.state
    when "new"
      content_tag :span, task.state, class: 'label label-info'
    when "started"
      content_tag :span, task.state, class: 'label label-success'
    when "finished"
      content_tag :span, task.state, class: 'label label-default'
    end
  end
end
