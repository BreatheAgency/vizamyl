module ApplicationHelper
  def bootstrap_devise_error_messages!
    return '' if resource.errors.empty?

    messages = resource.errors.full_messages.map { |msg| content_tag(:li, msg) }.join
    sentence = I18n.t('errors.messages.not_saved',
      count: resource.errors.count,
      resource: resource.class.model_name.human.downcase)

    html = <<-HTML
    <div class="row">
      <div class="small-12 large-12 columns with-content">
        <div class="row alert">
          <div class="small-0 large-6 columns">
          </div>
          <div class="small-12 large-6 columns">
            <p>#{sentence}</p>
            <ul>
              #{messages}
            </ul>
          </div>
        </div>
      </div>
    </div>
    HTML

    html.html_safe
  end
end
