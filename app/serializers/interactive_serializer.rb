class InteractiveSerializer < PageSerializer
  attributes :body

  def controller_name
    'interactive_page'
  end

  def template_name
    'interactive_page'
  end
end
