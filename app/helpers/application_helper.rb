module ApplicationHelper
  def body_class
    "#{controller.controller_name} #{controller.controller_name}-#{controller.action_name}"
  end

  def title(page_title)
    content_for(:title) { page_title + "- TellMyPolitician" }
  end
end
