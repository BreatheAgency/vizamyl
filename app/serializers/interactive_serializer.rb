class InteractiveSerializer < PageSerializer
  attributes :body, :sources

  def controller_name
    'interactive_page'
  end

  def template_name
    'interactive_page'
  end
end
