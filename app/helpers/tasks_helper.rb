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

    if (task.user == current_user || @current_user.is_admin?)
      status_label + " " + controlls
    else
      status_label
    end
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

  def attachment(task)
    file = %w(pdf doc docx)
    image = %w(jpg jpeg gif png)

    if task.attachment.present?
      if image.include?(task.attachment.file.extension)
        link_to task.attachment_url do
          image_tag task.attachment_url
        end
      else
        link_to 'Download the attachment', task.attachment_url
      end
    end
  end

  def has_attachment?(task)
    if task.attachment.present?
      link_to task.attachment_url do
        content_tag :i, '', class: 'fa fa-paperclip'
      end
    end
  end
end
